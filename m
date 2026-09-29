Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4539ECA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:56:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWRI-0001ce-SN; Tue, 29 Sep 2026 07:56:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1xBWRE-0001Y6-8L
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:56:00 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1xBWRC-0008T0-2c
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 07:55:59 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6aae37d33cbso1164922a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 04:55:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790682956; cv=none;
 d=google.com; s=arc-20260327;
 b=cQ4l1mFx1rHXBZbA897x0PZQvcssiGTQcCh6NBDuniL57zaa3RU/fDiHnKdK0Q5G+M
 d3Y2ZpmoRTmBjL4U86VQb001n1PviO2Trz0C1Bufn0XDzywXYoVwlorTZ841Rh0wxcBo
 v743m/DpQUH2sMfqCGaCM3UT+29zhtbysN2r1U9P/2qjUBT4McHCrILImeBQK4NHHGXY
 kveF5He571JVi1EsAPgCdB8N72vhD3pRPvbBXuzi85pmgWpKrXCOKM5tffJmmEq79MBG
 avr7hfiZ4E/4QPHAyEifQMC4g/7as0ciEYgPjYnnBMfhPO+HQt22ti1lPr30ufEofuVC
 2ovg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=L/AUE7z/S3HZbJnpo7hnSBOGf+Hsl2RJ9sPM/XIYPTw=;
 fh=2kYGgNObuMHp4dCltJDUttIfg1lV/fywA1MKdk7Ny2g=;
 b=lgJ8bTkYkGwPIfyZAzYG21ScWAZ0d0/nBMqNDolCDWJWyGgB2kyw8rNUaiaoAnaWk8
 kwY0hFrwRNiyU61EgQx7FFQHYboq21+IIvDZD9ArnQ0OjcJ3fVMD0IN9+3xS0B7ZeJVt
 EhC7WFIASoh4xFAqkgDRN3Sdyd86sVkVlwwd11jwmjz+GrehICQqS6w4nytfR4EmAOr2
 xBX+VrcwkDSxrgMjUf6MhjppStNmsvcrEAQaHHCSlXuSUF7/hbrQbqbaaiTYuCdvMmVF
 TWZyR21oGiJk7SOHokwPitz0AZXS5OgoRxEYyfeXdxJ1k65OipE2UZH5Iv/v70D6KREK
 yW3w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1790682956; x=1791287756; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=L/AUE7z/S3HZbJnpo7hnSBOGf+Hsl2RJ9sPM/XIYPTw=;
 b=YGviD5Nl2io4JSrPdR7IfYF2eacKgAFNxPff6CuV0TR+ZhzpcZzsIMDA1OBDuygTSR
 k9OCGcWJkO4wBDRb83JOv/65x7fc7J/LITM4go2UfGbRUcKSuq0ljxbka07KM0sJQRkn
 qXtWhnHHE0PVoPKroSrwSYg9OamNr18T73LaMQj6qRK1kke2ePF+4VKti5H7trwg5mGm
 bgXDrc6y9hWCuzFPehCzjnx/oA6WoApCh5q+zBlnfwAC9ay6RoZbuBaWwr1UQ9+V+enY
 UTY8GjSKhUFBYVBDDBh4FOHHK7eAGmmczDg9Mr2RgRCAJaLaCJoJGMc7GBa4bioJi1t2
 U/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790682956; x=1791287756;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L/AUE7z/S3HZbJnpo7hnSBOGf+Hsl2RJ9sPM/XIYPTw=;
 b=i0e9eN3YAJTWeA0US0I8kJm47L8v307Th1Y4Lt4rr81p0euZ8nlfxPvEQTxpTSxe5z
 AthYHB1HiiHOukhld1MSVBEpE8tYGpRRO8rjyoSJMBa9I/Wyxnf1yA2qW9H5gN/BuY0x
 4BfNQjOiWpjWjCJ8KeXC6sVsKLvuDv5v7dyZ487r9l/nBCJDR3fKU/trX/AfrUcIDAGM
 L+PRq3UVT/CE/OrowUeWLUBPO59+CwqL5u4ENELFD8qi1vW6C5AW+iMpJnUAAIWFabm6
 Xx1lqhjL4+xnDxUYv6NgeymFxAB+4b/z5J+7SmEJtzCkqaxsqRGb2lV7ZcCnnGE0eEvn
 Dh+g==
X-Gm-Message-State: AFq9FYLltVN80vWxNofrV4fUXfUAQkzUu7smPd4089rGD5aktbvmZQk9
 MLX/LSFtgssWf3n27wDNM1RTAMWnVz6sJdPNO/+5QPMWrTe0UoE7jUDv5AXl6IqMWVguV0AilBo
 YOi5fQ4Cab9xdV56pMnmZwV/CexjX5p0DJvzTYBms
X-Gm-Gg: AYBFou0truP20KvxsiCaq98/hlZng0woBj2HAcTrbk7YonkRFsERKBL4eTbW4Ud67Zx
 eHGwMMzvHqzTNqLdZewV2QWnFGHUfln9+ZapaT2e5MaRSS0zRmtt8EQKdClfH5D3q32DpPqkZQZ
 DMKlgaNsRXNfmuQBgodbVg5COno9AjhFquDMxJxQqKG8OQJiwuCVpbbovDNWwgSSQBUSu8jfq96
 LK+cDgGHuFQMFzx9/wpjBS0TUCbONSRO8Jmnuo/1b6SoT0ImH69waCscIoUnMJ/HPHAOIFl1i/i
 fHCtXq5NVJ4eMrzeD4G4o2t4HZIcrLUO2sYDKLy7JXb5NXyLl2w+Pdj6ytAOgJjZZB6RCTK2Q4h
 /1QXdg2V/6fVd8o0TyOtuk9Kv
X-Received: by 2002:a17:907:940d:b0:c26:1cfd:4244 with SMTP id
 a640c23a62f3a-c2df4cf87bcmr191939766b.11.1790682956303; Tue, 29 Sep 2026
 04:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260929101623.1352299-1-dtalexundeer@yandex-team.ru>
In-Reply-To: <20260929101623.1352299-1-dtalexundeer@yandex-team.ru>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Tue, 29 Sep 2026 13:55:45 +0200
X-Gm-Features: AclHuK9S5T0PiB5SRQjMtmZkNOIVYmAgYsEdM77FCr8878b0G0o5_tSOP4ayM3w
Message-ID: <CAJ307Egrw4xL0TOaiB3rnvprY5FSSNtGipLFiBUdEg7QLrjqhg@mail.gmail.com>
Subject: Re: [PATCH] vhost-user: add missing stub for
 vhost_user_has_protocol_feature()
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: qemu-devel@nongnu.org, 
 "yc-core @ yandex-team . ru" <yc-core@yandex-team.ru>,
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 29, 2026 at 12:16=E2=80=AFPM Alexandr Moshkov
<dtalexundeer@yandex-team.ru> wrote:
>
> Currently, building with --disable-vhost-user fails to link when other
> vhost backends are enabled: vhost.c calls vhost_user_has_protocol_feature=
(),
> but its implementation is not built.
>
> Add a stub returning false to fix the link error.
>
> Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

I'll let you decide if this is the best solution. Meanwhile,

Tested-by: Cl=C3=A9ment Chigot <chigot@adacore.com>

> ---
>  hw/virtio/vhost-user-stub.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/virtio/vhost-user-stub.c b/hw/virtio/vhost-user-stub.c
> index 45559788dd..9d2e521788 100644
> --- a/hw/virtio/vhost-user-stub.c
> +++ b/hw/virtio/vhost-user-stub.c
> @@ -4,3 +4,8 @@
>  void vhost_user_qmp_status(struct vhost_dev *dev, VirtioStatus *status)
>  {
>  }
> +
> +bool vhost_user_has_protocol_feature(struct vhost_dev *dev, uint64_t fea=
ture)
> +{
> +    return false;
> +}
> --
> 2.34.1
>

