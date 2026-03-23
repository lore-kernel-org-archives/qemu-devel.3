Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F296EC01C2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cUc-0001r1-PV; Mon, 23 Mar 2026 06:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4cUY-0001q5-6t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:26:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1w4cUS-0007l9-Fn
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774261591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l7iD04BaSjzY1aBhD4YS/S+AMnhgy6TMX/06CdMPW+c=;
 b=JfALr1IW812gV+czUn4hJQjITFJbTbffl40dJyMiU3fqbttni1fCTOYNRfSHES1J1hTEho
 TYPa4EVE5G9l0mzwGJJ9SKrcCnoAO0RfSTrW86Ht3f8myliqJrCgAAF8yKB4ODzox9P6Oe
 bUvRSI/ssuVEcdd4S1EA/B/W7qbwh/k=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-Ngtrha8ONZmV7M5o1YQmnA-1; Mon, 23 Mar 2026 06:26:30 -0400
X-MC-Unique: Ngtrha8ONZmV7M5o1YQmnA-1
X-Mimecast-MFC-AGG-ID: Ngtrha8ONZmV7M5o1YQmnA_1774261589
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7900fc7033bso84319517b3.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:26:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774261589; cv=none;
 d=google.com; s=arc-20240605;
 b=b5P/gYLOibGELheJfIF7xCRnwg/2F3eC+sl2GDePghkBKvuvWmC7pu/KQ9pcdZVLuT
 Nt86k3QqFF73PipPnxWN+gFZSml19m0P8C0Vzfj0Ij948/2DcE5CV3MzF+kjwHgkRl2j
 sSFGwEPYBWtZjTRa1C866oQgalJwjefrK2fA2IzJNRjxf12oEX+p9H6clwkltIeOjCOv
 eJNbBtEV2q5fpzOI0ClWOstc6JX2u5ETRjd1U/zavMCZ9B7fXvC4mkG0VmdS9pjbmwOz
 d5yDwzTp3p1BMN+SgeiHuz+44xh7Y4usn9p2hDguHpFG9A4lA5Vn0ufqX6d34cBVgkvv
 0wyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l7iD04BaSjzY1aBhD4YS/S+AMnhgy6TMX/06CdMPW+c=;
 fh=/Q1walrJ1rQppfQIaR5kN+L7c1qEv+piY1FwYfW9K3g=;
 b=GtlDU/np4+ppDvdPvaZbwZinWXq4V8ZwmRzjth0I9fVpJjZ/V+4aHwRTe4hislgBR6
 TQhwnFrBM2zwjpTf08OIGVGxsWmlDf/PXbpFoHLrG36LJRfD3fHtjDkMxueAZFP813Dt
 XMhS9kwEE/6dbPwQ/CdDgBBIvKeJWHrak2ajdu5KcE/A/oY2kqnGou34nTiUvo4FsLto
 SGyX1SiWQU4SI+fkhd3GUDGmm175dNghRPfmAlxCOmTQlGSAxUehJGgtYGcm4Ysitr9z
 FTV6ei2bjir/mdy7bIhlkaRLD/FYlPdpjCSLV39ayBs83JuF5CrXlNOEKJaQL/0wcAPd
 8ciw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774261589; x=1774866389; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l7iD04BaSjzY1aBhD4YS/S+AMnhgy6TMX/06CdMPW+c=;
 b=tVFhtIpYZquRCkW5oN4Qrm/WT4Nx8OWfRPxv2EiHUCDteHeX6A5YEQKqcdGRYKrtaN
 lIYhHcM4seja2eOjPOqe+fKwblcoCUGVnqRQhG1C/4m3tkwqNhcOcP/O5QJQcPNU3sEb
 h+2E/USIGQqKOjL4Flr4w8xXstjsHqQFnu8pu1wpfu3QrlEOax2iboM+JEc0O0ObLTWT
 fMGJgVlQXq3EddK+xbTcYcSeTiNfeQIaCN2r6z3Atib9ZA6VKK3eKGuiAf15J1eW0Pyx
 8z6k0J+4e9RgV1heW34uQGVMiZHSROuBkgxwKTjamK89s3RNrkPmu5zVLy88bFW4yegD
 V4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774261589; x=1774866389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l7iD04BaSjzY1aBhD4YS/S+AMnhgy6TMX/06CdMPW+c=;
 b=W6S9b7lYDMd93ZSUJvWxe+4dJDP/ZeHqsRTGz0tjdfWkq9H1OL9/8T84hZW8PN9Ma2
 80CmpJQoyk0GqYVCfSTYugKCjMIWwdGQCHcjENfDSJhg/QbgshgDnO5nR6gtXGGagSkI
 HtxG430A/24sw4nTxxV7kisGQtsePTFLcWpsq5LH771aABTSGR6YFwFgMZnQ8LRUuexS
 7nBgGDS5vBgOKzznIhjd4OjpXeKSKW+NnSQC5C+/V7GmzmBnVLKSppV8N7Kc3Zhaqgau
 nvM86XzFDpplbonLhScZpAcQzkMJH9te4pDQV8gC457wK9JkiIXQ35nYtCeuL05vADQ1
 20qQ==
X-Gm-Message-State: AOJu0YwVcPBU3t8oiddfDxVPscSFo1kqDqKz4X4amXLKqnItilPRqSM4
 PiHpSQpA4YlfoC52QzXXzGo2bZlg74NmK9Si+AueIDRYtmji2zxJp6biAFMdEvBdEadedq7o8Ho
 qosBNCHICm4DxJ4lQQA5WRKDVStRjJyr1yGEUBLfywR0zu99iThAJMfXGJwBNFa/hasiBCe0mcj
 zmf4CciTNIEdtoWWUM7vtR/wJbToZJE1A=
X-Gm-Gg: ATEYQzwfiblwPNMLWOJzcEWPo+Xme6JEuHrauF78IXrXlkBe4P1lzpt9Ufaa5U0CS60
 oLc6PlMcw557OPLuFynhTDzJFUuAKUG966OOKG1OYxGfLndDPq2lrbIZp+iwQIB6qQCwwkI3TMX
 IARYKM81KlOIaTt9IypkBbtjL8Wd0T/ZWCRzjx48cEeYINT62PljeP/ihVx45KOamGhIRgUTZLA
 eWAWw==
X-Received: by 2002:a05:690c:34c9:b0:796:3858:a084 with SMTP id
 00721157ae682-79a81b9a546mr147659057b3.19.1774261589356; 
 Mon, 23 Mar 2026 03:26:29 -0700 (PDT)
X-Received: by 2002:a05:690c:34c9:b0:796:3858:a084 with SMTP id
 00721157ae682-79a81b9a546mr147658917b3.19.1774261588941; Mon, 23 Mar 2026
 03:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260320142015.3856652-1-jonah.palmer@oracle.com>
 <20260320142015.3856652-2-jonah.palmer@oracle.com>
In-Reply-To: <20260320142015.3856652-2-jonah.palmer@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 23 Mar 2026 11:25:52 +0100
X-Gm-Features: AaiRm508gCl5QohsZlrzNswDteFyzMyTWgonMhxKZJQHl9rs71PtsacyfUF_Ey4
Message-ID: <CAJaqyWf5==jZxJErazeAea1NxpGB2SFNdpAPh7bi5tc69FytTw@mail.gmail.com>
Subject: Re: [RFC v2 01/14] machine,virtio-net: add early-mig property
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com, 
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com, 
 mst@redhat.com, sgarzare@redhat.com, jasowang@redhat.com, leiyang@redhat.com, 
 si-wei.liu@oracle.com, boris.ostrovsky@oracle.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 20, 2026 at 3:20=E2=80=AFPM Jonah Palmer <jonah.palmer@oracle.c=
om> wrote:
>
> Introduce a new 'early-mig' property that enables the early migration
> path for virtio-net devices on machine types >=3D 10.2:
>
>  - virtio-net-device,early-mig=3Don
>  - virtio-net-pci,early-mig=3Don
>  - virtio-net-pci-transitional,early-mig=3Don
>  - virtio-net-pci-non-transitional,early-mig=3Don
>  - virtio-net-ccw,early-mig=3Don
>
> To preserve compatibility for older machine types (<=3D 10.1), add compat
> overrides in hw_compat_10_1 to keep the legacy default (off).
>
> With this, machine types 10.2 and newer enable early migration by
> default while older machine types retain the previous behavior. Users
> may still override explicitly via:
>
>  -device virtio-net-pci,early-mig=3Doff
>  or
>  -global virtio-net-device.early-mig=3Doff
>
> Follow-up patches will implement the actual early migration feature for
> virtio-net devices.
>
> Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
> ---
>  hw/core/machine.c              | 5 +++++
>  hw/net/virtio-net.c            | 1 +
>  include/hw/virtio/virtio-net.h | 1 +
>  3 files changed, 7 insertions(+)
>
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 6cf0e2f404..1b6c7db119 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -45,6 +45,11 @@ const size_t hw_compat_10_2_len =3D G_N_ELEMENTS(hw_co=
mpat_10_2);
>
>  GlobalProperty hw_compat_10_1[] =3D {
>      { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> +    { "virtio-net-device", "early-mig", "off" },
> +    { "virtio-net-pci", "early-mig", "off" },
> +    { "virtio-net-pci-transitional", "early-mig", "off" },
> +    { "virtio-net-pci-non-transitional", "early-mig", "off" },
> +    { "virtio-net-ccw", "early-mig", "off" },

Is this needed even if we mark the VMState as optional?

The source might not be able to send the device configuration in some
cases. For example, if it cannot shadow CVQ. If the destination knows
this field is optional, the QEMU source version is irrelevant.

>      { TYPE_VIRTIO_NET, "host_tunnel", "off" },
>      { TYPE_VIRTIO_NET, "host_tunnel_csum", "off" },
>      { TYPE_VIRTIO_NET, "guest_tunnel", "off" },
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 2a5d642a64..12b3456ca2 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -4258,6 +4258,7 @@ static const Property virtio_net_properties[] =3D {
>                        VIRTIO_NET_F_GUEST_USO6, true),
>      DEFINE_PROP_BIT64("host_uso", VirtIONet, host_features,
>                        VIRTIO_NET_F_HOST_USO, true),
> +    DEFINE_PROP_BOOL("early-mig", VirtIONet, early_mig, true),
>      DEFINE_PROP_ON_OFF_AUTO_BIT64("hash-ipv4", VirtIONet,
>                                    rss_data.specified_hash_types,
>                                    VIRTIO_NET_HASH_REPORT_IPv4 - 1,
> diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-ne=
t.h
> index 371e376428..ddb141fefc 100644
> --- a/include/hw/virtio/virtio-net.h
> +++ b/include/hw/virtio/virtio-net.h
> @@ -230,6 +230,7 @@ struct VirtIONet {
>      struct EBPFRSSContext ebpf_rss;
>      uint32_t nr_ebpf_rss_fds;
>      char **ebpf_rss_fds;
> +    bool early_mig;
>  };
>
>  size_t virtio_net_handle_ctrl_iov(VirtIODevice *vdev,
> --
> 2.51.0
>


