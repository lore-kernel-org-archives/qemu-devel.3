Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F11FD4F04
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 16:10:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzzeu-0006JO-Rh; Tue, 10 Mar 2026 12:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vzzej-0006Hz-14
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:10:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1vzzeg-00069G-Gs
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 12:10:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773158997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EVvTSIvyeyWlTKwhZchV0DAhs39+2S0bqKPBwjXj6Jg=;
 b=GRZDWyCeC5yUx72hJTWxcLoDfsXHrp51PT+D/Q5ilfVFk+0sbuGPtCgx2Stjfz6LLxHrp/
 HKSuamY0ggm7iR5gNnEDmYeN7kYJ8zqmbxEe71vTAGAzkU+8VabQJV5UzqQ0Iv1BQUKqsY
 9FonanennaiK1sUtZPX778QQYOoyHIs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-TtUjb0mdPcWcArbk2fEIbw-1; Tue, 10 Mar 2026 12:09:55 -0400
X-MC-Unique: TtUjb0mdPcWcArbk2fEIbw-1
X-Mimecast-MFC-AGG-ID: TtUjb0mdPcWcArbk2fEIbw_1773158995
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35979a03106so10240113a91.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 09:09:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158991; cv=none;
 d=google.com; s=arc-20240605;
 b=QVvZIp+6GS1x9q/svL5tZF8dL5k2F0qA/l4bZp0rgqwij5xslFvOx2UC82ach9MmWF
 x6DvJrP7tZUHW95AxZOt9luiOw0+79L9eXYEQ1cPRInw90tCtwtIjFpOdCD1/MeDOeMJ
 LgrGAlMHkMKFSQ+nHmkyyxSTw14QqKbiDKaQdGtP6JiaaQ1aNQRrF7EqdwP+vZ6K/s2D
 8qKmZZzHtFaCSOmBNTEQlPS38sh8kC88PQbyE0vxevxRZ4aFv1axrnPuh/Rc59Io6tCn
 yE2+euAQhPrgavI3+FlDsjsrsTZn2U1Uj2BFbeell2vaDKaaML72Q4JzmsyNIYU/LeQx
 5fIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EVvTSIvyeyWlTKwhZchV0DAhs39+2S0bqKPBwjXj6Jg=;
 fh=WJiSE9L9bP6bMI22Q1bNB3BQuHLgO/P5i3Fqrijhs3g=;
 b=AIPNZRiNGib5BhPbwWQ6QytwvSJSddPojD3t8taLG4dlg5YivVF/o6QzePM2NZjU3Q
 QnpFNyMviBl7B9pt3Xq6breUMOIY4n6E4isOsjK9F+AD0ApU0yP2roXIEYrMxHxZJ21d
 6pdqg2aq8V7bgmKCXwL/hpomuzpyDOUFJT/PwmDT95F6A68uwCsneZdYsHxTT15EJGrE
 PBHvygXcnS57tUkfybBnLRpkcukXd45uKY6b/sfcrTrhbh4hQACAnplwyvO6P8KQSCqk
 285Qr8CoXBwsU7Z7TW3uRTv2qc6iiZBVuuI/s3vDaP0NH/PLNwPzangrPpFagcs9UjHd
 rU5w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773158991; x=1773763791; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EVvTSIvyeyWlTKwhZchV0DAhs39+2S0bqKPBwjXj6Jg=;
 b=kDKToPjsADezVHbWK8Tcu9IE+ltVybvGt0EHSWpWsVDtUa39tGpWG0rMM8wWAeuA/S
 4aaWw3Q59Fdp/pajJ/2YhQBLUrUB/0qreL9kWNOIuX0ObjBWEEh8eep4qWM83JcM5s32
 A9CgKlyfMjXrBI/PQ42tCCPSZWsVeuPO7I0Ah5iDLQzX00A5nwQ0M0cGLY14S6soxHKR
 uyXdeI3PJRyhOsZk5OyBAQuDIlXn9w4hMjuVzdHXmapXcjB/psMkhfoIJoFFLxb5Lc1I
 7wUvY8/oK8PNRRCY1rTZvs5oFMVxRMyMlyfGrBS4nNFdPImq34yHiuigqjlGJyyrpK+i
 DFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158991; x=1773763791;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EVvTSIvyeyWlTKwhZchV0DAhs39+2S0bqKPBwjXj6Jg=;
 b=jEYE4pdEXdIxx2o1VxSyRxKR1OdwGvPmkoJDWCbEn+Owky69Uks6Lmg9AeNX2a3FTH
 8lf5OISqjkHfTkYXvv4mcdmj2knWfrBS2EU74GtMAU1D6nxzO3iNkGwpkOYPYlgawn3k
 1CAjNMxgZDXoHwOLY0idCdk6dgHmnnajJtzN5DYWAENh+qav7Ng5MdrwbSaRNXWSA6CR
 Y9OsMwYBxS8eSCwUAoVy9bnmsP0as25XwuRGK+M6LGShktCK9mIeCDAHNVeBMKpodwXX
 Edc65T73mRYx7mIpmb4HtM59t55wBOTN04LaZrOsBPJPfofj1VV2Wj485oaqOTpexFnm
 HtKg==
X-Gm-Message-State: AOJu0Yzi1aIfE5WA19WT2wiZCE0obF6weopEfTJLOdqDk+enHRvc55+K
 wccDlvBOC7tohEkSGOJCvLI4/mB4ej6UgZ/60dpqdWDEd+1qaZzZZlze2PLKmwRfFTEY5mBPYWL
 9SqqU6zHk/CbbdMIc9d+Wvimt5o0KS8iBQ0gsPfS2CM4//JcYx5lHkmA4n77UTd41h007N4e1Ng
 YZYW0mSgAbHjNGV9aLGFrz+ZVPnr1X76Y=
X-Gm-Gg: ATEYQzx25yUVLYOE8fWy+k+bsZN+1S5MgX9Un9RK3rUxkmeaNGWUn5N8llAGO+LF6f0
 sS4+vgX66Zr3MtvXYnnzNU6Mp7mtRY1dvDV5Z0zKGCx8NEZnErPuSfpobTLD+EVgHBn998Xjzjv
 8sQ+aHFhYa889smmlp5goSOQcNEouF/roy2sD/eTIDkobbbFU+DCVSuRS6yKUynuoQlAeNY0tJ8
 l29M23hH2wnoRCqEydPy2MYWWCTsRg2EiyRlYVauIArIY4PudhUikXCy7C27plh0bYj9b9B1w0R
 k1zQ2zD418LW/RIGcxjN5QM=
X-Received: by 2002:a17:90b:4c0b:b0:340:bfcd:6af8 with SMTP id
 98e67ed59e1d1-359be21cbe3mr13385910a91.4.1773158990765; 
 Tue, 10 Mar 2026 09:09:50 -0700 (PDT)
X-Received: by 2002:a17:90b:4c0b:b0:340:bfcd:6af8 with SMTP id
 98e67ed59e1d1-359be21cbe3mr13385885a91.4.1773158990317; Tue, 10 Mar 2026
 09:09:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <ce681660-d47c-4ba6-9237-eef55a87493c@intel.com>
In-Reply-To: <ce681660-d47c-4ba6-9237-eef55a87493c@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 10 Mar 2026 17:09:38 +0100
X-Gm-Features: AaiRm53D_fI1H70-F1ikhogxji9xkIEVV_aZIVYBCcLuGeymmaChwnXNt6tcmrY
Message-ID: <CAMxuvaycCnFjhqtv5Gvi93W-ndEDqFbdgTn-pmYbyMAOW-v7CQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] Make RamDiscardManager work with multiple sources
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Mark Kanda <mark.kanda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Tue, Mar 10, 2026 at 6:35=E2=80=AFAM Chenyi Qiang <chenyi.qiang@intel.co=
m> wrote:
>
>
>
> On 2/26/2026 9:59 PM, marcandre.lureau@redhat.com wrote:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > Hi,
> >
> > This is an attempt to fix the incompatibility of virtio-mem with confid=
ential
> > VMs. The solution implements what was discussed earlier with D. Hildenb=
rand:
> > https://patchwork.ozlabs.org/project/qemu-devel/patch/20250407074939.18=
657-5-chenyi.qiang@intel.com/#3502238
> >
> > The first patches are misc cleanups. Then some code refactoring to have=
 split a
> > manager/source. And finally, the manager learns to deal with multiple s=
ources.
> >
> > I haven't done thorough testing. I only launched a SEV guest with a vir=
tio-mem
> > device. It would be nice to have more tests for those scenarios with
> > VFIO/virtio-mem/confvm.. In any case, review & testing needed!
>
> Is this series aimed to enable virtio-mem (memory hotplug) in a confident=
ial VM?
> I tested it within a TD guest using the qemu command:
>
> qemu-system-x86_64
>         ...
>         -m 2G,maxmem=3D10G \
>         -smp sockets=3D1,cores=3D2 \
>         -object memory-backend-ram,id=3Dmem0,size=3D2G \
>         -numa node,nodeid=3D0,cpus=3D0-1,memdev=3Dmem0 \
>         -object memory-backend-ram,id=3Dvmem0,size=3D8G \
>         -device virtio-mem-pci,id=3Dvm0,memdev=3Dvmem0,node=3D0,requested=
-size=3D300M \
>         -object tdx-guest,id=3Dtdx \
>         -machine q35,kernel_irqchip=3Dsplit,hpet=3Doff,memory-encryption=
=3Dtdx \
>         ...
>
> The TD VM will exit with the error when the guest kernel loads the virtio=
-mem driver:
>
>     kvm_intel: Guest access before accepting 0x108008000 on vCPU 0
>
> I think it still lacks some support to accept the TD guest memory before =
using it.
>

It becomes increasingly hard to provide easy to setup reproducibe
environments.. but here is the libvirt qemu command I just tested
succesfully against:

qemu-system-x86_64 -name guest=3Drhel10,debug-threads=3Don -S -object
{"qom-type":"secret","id":"masterKey0","format":"raw","file":"/home/elmarco=
/.config/libvirt/qemu/lib/domain-3-rhel10/master-key.aes"}
-machine pc-q35-10.1,usb=3Doff,smm=3Doff,dump-guest-core=3Doff,confidential=
-guest-support=3Dlsec0,hpet=3Doff,acpi=3Don
-accel kvm -cpu host,migratable=3Don -bios
/usr/share/edk2/ovmf/OVMF.inteltdx.fd -m
size=3D4096000k,slots=3D1,maxmem=3D8192000k -overcommit mem-lock=3Doff -smp
2,sockets=3D2,cores=3D1,threads=3D1 -object
{"qom-type":"memory-backend-ram","id":"ram-node0","size":4194304000}
-numa node,nodeid=3D0,cpus=3D0-1,memdev=3Dram-node0 -uuid
0f3e6b74-80e3-45e7-a0e6-ae7dfc897606 -display none -no-user-config
-nodefaults -chardev socket,id=3Dcharmonitor,fd=3D23,server=3Don,wait=3Doff
-mon chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc
base=3Dutc,driftfix=3Dslew -global kvm-pit.lost_tick_policy=3Ddelay
-no-shutdown -global ICH9-LPC.disable_s3=3D1 -global
ICH9-LPC.disable_s4=3D1 -boot strict=3Don -device
{"driver":"pcie-root-port","port":8,"chassis":1,"id":"pci.1","bus":"pcie.0"=
,"multifunction":true,"addr":"0x1"}
-device {"driver":"pcie-root-port","port":9,"chassis":2,"id":"pci.2","bus":=
"pcie.0","addr":"0x1.0x1"}
-device {"driver":"pcie-root-port","port":10,"chassis":3,"id":"pci.3","bus"=
:"pcie.0","addr":"0x1.0x2"}
-device {"driver":"pcie-root-port","port":11,"chassis":4,"id":"pci.4","bus"=
:"pcie.0","addr":"0x1.0x3"}
-device {"driver":"pcie-root-port","port":12,"chassis":5,"id":"pci.5","bus"=
:"pcie.0","addr":"0x1.0x4"}
-device {"driver":"pcie-root-port","port":13,"chassis":6,"id":"pci.6","bus"=
:"pcie.0","addr":"0x1.0x5"}
-device {"driver":"pcie-root-port","port":14,"chassis":7,"id":"pci.7","bus"=
:"pcie.0","addr":"0x1.0x6"}
-device {"driver":"pcie-root-port","port":15,"chassis":8,"id":"pci.8","bus"=
:"pcie.0","addr":"0x1.0x7"}
-device {"driver":"pcie-root-port","port":16,"chassis":9,"id":"pci.9","bus"=
:"pcie.0","multifunction":true,"addr":"0x2"}
-device {"driver":"pcie-root-port","port":17,"chassis":10,"id":"pci.10","bu=
s":"pcie.0","addr":"0x2.0x1"}
-device {"driver":"pcie-root-port","port":18,"chassis":11,"id":"pci.11","bu=
s":"pcie.0","addr":"0x2.0x2"}
-device {"driver":"pcie-root-port","port":19,"chassis":12,"id":"pci.12","bu=
s":"pcie.0","addr":"0x2.0x3"}
-device {"driver":"pcie-root-port","port":20,"chassis":13,"id":"pci.13","bu=
s":"pcie.0","addr":"0x2.0x4"}
-device {"driver":"pcie-root-port","port":21,"chassis":14,"id":"pci.14","bu=
s":"pcie.0","addr":"0x2.0x5"}
-device {"driver":"qemu-xhci","p2":15,"p3":15,"id":"usb","bus":"pci.2","add=
r":"0x0"}
-device {"driver":"virtio-serial-pci","id":"virtio-serial0","bus":"pci.3","=
addr":"0x0"}
-object {"qom-type":"memory-backend-ram","id":"memvirtiomem0","reserve":fal=
se,"size":4194304000}
-device {"driver":"virtio-mem-pci","node":0,"block-size":2097152,"memdev":"=
memvirtiomem0","id":"virtiomem0","bus":"pci.7","addr":"0x0"}
-blockdev {"driver":"file","filename":"/home/elmarco/rhel-10.qcow2","node-n=
ame":"libvirt-1-storage","auto-read-only":true,"discard":"unmap"}
-blockdev {"node-name":"libvirt-1-format","read-only":false,"driver":"qcow2=
","file":"libvirt-1-storage","backing":null}
-device {"driver":"virtio-blk-pci","bus":"pci.4","addr":"0x0","drive":"libv=
irt-1-format","id":"virtio-disk0","bootindex":1}
-netdev {"type":"user","id":"hostnet0"} -device
{"driver":"virtio-net-pci","netdev":"hostnet0","id":"net0","mac":"52:54:00:=
82:08:40","bus":"pci.1","addr":"0x0"}
-chardev pty,id=3Dcharserial0 -device
{"driver":"isa-serial","chardev":"charserial0","id":"serial0","index":0}
-chardev socket,id=3Dcharchannel0,fd=3D22,server=3Don,wait=3Doff -device
{"driver":"virtserialport","bus":"virtio-serial0.0","nr":1,"chardev":"charc=
hannel0","id":"channel0","name":"org.qemu.guest_agent.0"}
-chardev socket,id=3Dchrtpm,path=3D/run/user/1006/libvirt/qemu/run/swtpm/3-=
rhel10-swtpm.sock
-tpmdev emulator,id=3Dtpm-tpm0,chardev=3Dchrtpm -device
{"driver":"tpm-crb","tpmdev":"tpm-tpm0","id":"tpm0"} -audiodev
{"id":"audio1","driver":"none"} -global ICH9-LPC.noreboot=3Doff
-watchdog-action reset -device
{"driver":"virtio-balloon-pci","id":"balloon0","bus":"pci.5","addr":"0x0"}
-object {"qom-type":"rng-random","id":"objrng0","filename":"/dev/urandom"}
-device {"driver":"virtio-rng-pci","rng":"objrng0","id":"rng0","bus":"pci.6=
","addr":"0x0"}
-object {"qom-type":"tdx-guest","id":"lsec0","quote-generation-socket":{"ty=
pe":"unix","path":"/var/run/tdx-qgs/qgs.socket"},"attributes":268435456}
-sandbox on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcec=
ontrol=3Ddeny
-msg timestamp=3Don

Then I hotplugged some mem:
virsh --connect qemu:///session update-memory-device rhel10
--requested-size 2GiB

[  166.228943] virtio_mem virtio5: plugged size: 0x0
[  166.231784] virtio_mem virtio5: requested size: 0x80000000


[root@rhel10-server ~]# lsmem
RANGE                                 SIZE  STATE REMOVABLE BLOCK
0x0000000000000000-0x000000007fffffff   2G online       yes  0-15
0x0000000100000000-0x00000001ffffffff   4G online       yes 32-63

Memory block size:       128M
Total online memory:       6G
Total offline memory:      0B

The host kernel used is experimental; it's a patched version of
6.19.0-rc8 that I don't have the details)

> >
> > (should fix https://issues.redhat.com/browse/RHEL-131968)
> >
> > v3: issues found by C=C3=A9dric
> >  - fix assertion error on shutdown, due to rcu-defer cleanup
> >  - fix API doc warnings
> >
> > v2:
> >  - drop replay_{populated,discarded} from source, suggested by Peter Xu
> >  - add extra manager cleanup
> >  - add r-b tags for preliminary patches
> >
> > thanks
> >
> > Marc-Andr=C3=A9 Lureau (15):
> >   system/rba: use DIV_ROUND_UP
> >   memory: drop RamDiscardListener::double_discard_supported
> >   virtio-mem: use warn_report_err_once()
> >   system/memory: minor doc fix
> >   kvm: replace RamDicardManager by the RamBlockAttribute
> >   system/memory: split RamDiscardManager into source and manager
> >   system/memory: move RamDiscardManager to separate compilation unit
> >   system/memory: constify section arguments
> >   system/ram-discard-manager: implement replay via is_populated
> >     iteration
> >   virtio-mem: remove replay_populated/replay_discarded implementation
> >   system/ram-discard-manager: drop replay from source interface
> >   system/memory: implement RamDiscardManager multi-source aggregation
> >   system/physmem: destroy ram block attributes before RCU-deferred
> >     reclaim
> >   system/memory: add RamDiscardManager reference counting and cleanup
> >   tests: add unit tests for RamDiscardManager multi-source aggregation
> >
> >  include/hw/vfio/vfio-container.h            |    2 +-
> >  include/hw/vfio/vfio-cpr.h                  |    2 +-
> >  include/hw/virtio/virtio-mem.h              |    3 -
> >  include/system/memory.h                     |  287 +----
> >  include/system/ram-discard-manager.h        |  358 ++++++
> >  include/system/ramblock.h                   |    3 +-
> >  accel/kvm/kvm-all.c                         |    2 +-
> >  hw/vfio/cpr-legacy.c                        |    4 +-
> >  hw/vfio/listener.c                          |   12 +-
> >  hw/virtio/virtio-mem.c                      |  290 +----
> >  migration/ram.c                             |    6 +-
> >  system/memory.c                             |   83 +-
> >  system/memory_mapping.c                     |    4 +-
> >  system/physmem.c                            |    2 +-
> >  system/ram-block-attributes.c               |  279 +----
> >  system/ram-discard-manager.c                |  612 +++++++++
> >  tests/unit/test-ram-discard-manager-stubs.c |   48 +
> >  tests/unit/test-ram-discard-manager.c       | 1234 +++++++++++++++++++
> >  system/meson.build                          |    1 +
> >  tests/unit/meson.build                      |    8 +-
> >  20 files changed, 2361 insertions(+), 879 deletions(-)
> >  create mode 100644 include/system/ram-discard-manager.h
> >  create mode 100644 system/ram-discard-manager.c
> >  create mode 100644 tests/unit/test-ram-discard-manager-stubs.c
> >  create mode 100644 tests/unit/test-ram-discard-manager.c
> >
>


