Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E8EC982FF
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 12:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x900t-0000lw-4T; Tue, 22 Sep 2026 08:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.carrara@proxmox.com>)
 id 1x900q-0000lf-TO; Tue, 22 Sep 2026 08:54:21 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <m.carrara@proxmox.com>)
 id 1x900o-0003AP-Jt; Tue, 22 Sep 2026 08:54:20 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B0775421F0;
 Tue, 22 Sep 2026 14:54:07 +0200 (CEST)
From: "Max R. Carrara" <m.carrara@proxmox.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH] block: vmdk: support raw device mappings in vmdk format
Date: Tue, 22 Sep 2026 14:54:03 +0200
Message-ID: <20260922-2026-09-support-rdm-import-from-esxi-v1-v1-1-2c8c8644d233@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260922-2026-09-support-rdm-import-from-esxi-v1-7f601c111381
X-Mailer: b4 0.14.2
Content-Transfer-Encoding: quoted-printable
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790081646394
Received-SPF: pass client-ip=94.136.29.106; envelope-from=m.carrara@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Implement support for raw device mappings (RDMs) in QEMU's VMDK block=0D
driver. Handle both virtual and physical compatibility modes. This=0D
allows us to import RDM disks from ESXi through our FUSE layer without=0D
any additional changes inside Proxmox VE.=0D
=0D
According to the vSphere docs, an RDM provides a mechanism for a VM to=0D
have direct access to a LUN on physical storage [rdm]. What it really=0D
does is simply pass through a block device to a VM. The VMDK for an=0D
RDM will reference a so-called "pointer file" in its extent=0D
description, with the type `VMFSRDM`, which is created alongide the=0D
VMDK file. This pointer file then points to the block device, kind of=0D
like a symlink.=0D
=0D
- Physical compatibility mode=0D
=0D
  In the "Disk DescriptorFile" section:=0D
  `createType=3D"vmfsPassthroughRawDeviceMap"`=0D
=0D
  This is the simplest of the two modes; the block device is simply=0D
  passed through to the VM. RDMs in this compat mode are excluded from=0D
  snapshots.=0D
=0D
  On ESXi, such RDMs can be created with:=0D
=0D
    vmkfstools --createrdmpassthru \=0D
      /vmfs/devices/disks/... [PATH TO NEW VMDK]=0D
=0D
- Virtual compatibility mode=0D
=0D
  In the "Disk DescriptorFile" section:=0D
  `createType=3D"vmfsRawDeviceMap"`=0D
=0D
  This mode allows RDMs to be included in snapshots. When making a=0D
  snapshot, the new delta is written to a SESPARSE file on the=0D
  datastore instead, and the data on the passthrough disk will remain=0D
  unmodified from that point onwards.=0D
=0D
  On ESXi, such RDMs can be created with:=0D
=0D
    vmkfstools --createrdm \=0D
      /vmfs/devices/disks/... [PATH TO NEW VMDK]=0D
=0D
In order to support both of these modes, make the VMDK block driver=0D
aware of the `vmfsPassthroughRawDeviceMap` and `vmfsRawDeviceMap`=0D
createTypes. Then, handle the `VMFSRDM` extent type in the extents=0D
parser.=0D
=0D
The `VMFSRDM` extent type works similar to the regular `VMFS` and=0D
`FLAT` types. The entire extent's description consists of four fields;=0D
the referenced file points to a raw block device and thus stores no=0D
metadata. Therefore, this file can be treated just like a `FLAT`=0D
extent and read directly.=0D
=0D
[rdm]: https://techdocs.broadcom.com/us/en/vmware-cis/vsphere/vsphere/7-0/v=
sphere-storage/raw-device-mapping-in-vsphere.html=0D
=0D
Signed-off-by: Max R. Carrara <m.carrara@proxmox.com>=0D
---=0D
=0D
Hello!=0D
=0D
Some context: Our FUSE layer in Proxmox VE allows us to mount the VMware=0D
filesystem on ESXi directly on our side, which makes migrating VMs from=0D
ESXi to PVE possible using our import tools. However, we currently=0D
cannot import RDM disks, since QEMU's VMDK driver does not support them.=0D
=0D
I was advised to upstream this here directly instead of patching our=0D
downstream version. So, I'd appreciate any feedback! :)=0D
=0D
How I tested this:=0D
=0D
1. Create a physical and virtual RDM each on ESXi=0D
=0D
2. Assign the RDMs to a plain Debian VM=0D
=0D
3. Boot up the VM and write over the disks with /dev/urandom from inside=0D
   the VM=0D
=0D
4. Run a `sha256sum` for each disk inside the VM and note down the=0D
   checksums=0D
=0D
5. Configure the ESXi host on Proxmox VE=0D
=0D
6. Import the Debian VM with the two RDM disks=0D
=0D
7. Boot up the VM once the import has been completed (if doing a=0D
   non-live import) and run the checksums again=0D
=0D
Alternatively, it is also possible to use our [tooling] directly; I can=0D
provide the steps for that, if desired. That makes it possible to=0D
convert images directly, run `qemu-img compare` w/ the mounted disks,=0D
etc.=0D
=0D
FWIW, I did that as well and got matching images.=0D
=0D
Thanks a lot! :)=0D
=0D
Best regards,=0D
Max R. Carrara=0D
=0D
[tooling]: https://git.proxmox.com/?p=3Dpve-esxi-import-tools.git;a=3Dtree;=
h=3Drefs/heads/master;hb=3Drefs/heads/master=0D
=0D
 block/vmdk.c | 13 ++++++++-----=0D
 1 file changed, 8 insertions(+), 5 deletions(-)=0D
=0D
diff --git a/block/vmdk.c b/block/vmdk.c=0D
index cd8b4ec7c88187188e79801bd71dd9da42223db0..22f67e351bee2582023653709fa=
8c4859081b4c4 100644=0D
--- a/block/vmdk.c=0D
+++ b/block/vmdk.c=0D
@@ -1174,6 +1174,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState=
 *bs, QDict *options,=0D
          * RW [size in sectors] VMFS "file-name.vmdk"=0D
          * RW [size in sectors] VMFSSPARSE "file-name.vmdk"=0D
          * RW [size in sectors] SESPARSE "file-name.vmdk"=0D
+         * RW [size in sectors] VMFSRDM "file-name.vmdk"=0D
          */=0D
         flat_offset =3D -1;=0D
         matches =3D sscanf(p, "%10s %" SCNd64 " %10s \"%511[^\n\r\"]\" %" =
SCNd64,=0D
@@ -1184,7 +1185,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState=
 *bs, QDict *options,=0D
             if (matches !=3D 5 || flat_offset < 0) {=0D
                 goto invalid;=0D
             }=0D
-        } else if (!strcmp(type, "VMFS")) {=0D
+        } else if (!strcmp(type, "VMFS") || !strcmp(type, "VMFSRDM")) {=0D
             if (matches =3D=3D 4) {=0D
                 flat_offset =3D 0;=0D
             } else {=0D
@@ -1197,7 +1198,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState=
 *bs, QDict *options,=0D
         if (sectors <=3D 0 ||=0D
             (strcmp(type, "FLAT") && strcmp(type, "SPARSE") &&=0D
              strcmp(type, "VMFS") && strcmp(type, "VMFSSPARSE") &&=0D
-             strcmp(type, "SESPARSE")) ||=0D
+             strcmp(type, "SESPARSE") && strcmp(type, "VMFSRDM")) ||=0D
             (strcmp(access, "RW"))) {=0D
             continue;=0D
         }=0D
@@ -1224,7 +1225,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState=
 *bs, QDict *options,=0D
         assert(ret < 32);=0D
=0D
         extent_role =3D BDRV_CHILD_DATA;=0D
-        if (strcmp(type, "FLAT") !=3D 0 && strcmp(type, "VMFS") !=3D 0) {=
=0D
+        if (strcmp(type, "FLAT") !=3D 0 && strcmp(type, "VMFS") !=3D 0 && =
strcmp(type, "VMFSRDM")) {=0D
             /* non-flat extents have metadata */=0D
             extent_role |=3D BDRV_CHILD_METADATA;=0D
         }=0D
@@ -1242,7 +1243,7 @@ vmdk_parse_extents(const char *desc, BlockDriverState=
 *bs, QDict *options,=0D
         }=0D
=0D
         /* save to extents array */=0D
-        if (!strcmp(type, "FLAT") || !strcmp(type, "VMFS")) {=0D
+        if (!strcmp(type, "FLAT") || !strcmp(type, "VMFS") || !strcmp(type=
, "VMFSRDM")) {=0D
             /* FLAT extent */=0D
=0D
             ret =3D vmdk_add_extent(bs, extent_file, true, sectors,=0D
@@ -1334,7 +1335,9 @@ vmdk_open_desc_file(BlockDriverState *bs, int flags, =
char *buf, QDict *options,=0D
         strcmp(ct, "vmfsSparse") &&=0D
         strcmp(ct, "seSparse") &&=0D
         strcmp(ct, "twoGbMaxExtentSparse") &&=0D
-        strcmp(ct, "twoGbMaxExtentFlat")) {=0D
+        strcmp(ct, "twoGbMaxExtentFlat") &&=0D
+        strcmp(ct, "vmfsRawDeviceMap") &&=0D
+        strcmp(ct, "vmfsPassthroughRawDeviceMap")) {=0D
         error_setg(errp, "Unsupported image type '%s'", ct);=0D
         ret =3D -ENOTSUP;=0D
         goto exit;=0D
=0D
---=0D
base-commit: c3d48b7d1e89604920e5b81b91140c2ad39a1943=0D
change-id: 20260922-2026-09-support-rdm-import-from-esxi-v1-7f601c111381=0D
--=0D
=0D


