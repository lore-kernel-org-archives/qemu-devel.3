Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55724CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 10:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGDRO-0001Zy-L6; Mon, 12 Oct 2026 06:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDRN-0001Yi-68
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:39:33 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xGDRL-0006iq-Ds
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 06:39:32 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2d6d28aa26cso7540275ad.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791801569; x=1792406369; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FaqkEwa9SJzlxounBdIQKUjQbypNuudMXhqlY7Q9WMI=;
 b=NKLfvH19U/xi2G4iW9Q30LPcRlJJfuPm9L9nYKE7Y0nF6WyWgpazsoVNQe8YWIyhf6
 VNF8O9XNIHe2odBP2CjKxKc85ZwiWUeJuMldX7R4kFvfXfK/B8Nl1VA82lgaZwyZjg/C
 1Kki3g5scjPa/QFG1ppPRflhe7NTQgKwSBspy6gGCyvYLp+fVc3k1Uy+3iCw4NXWnw+M
 GMw71S8QP5zqFQ8g1QWvnVthheJE7PMzDyLAcQ4CYwUE34nWVGWyR1phEWd3CSDeg23T
 03E0r5m6xPJ+fGu0yuMscJRVsrWrACBQNnfFhXDd7KWXZcNEPQx4JRxVmj5oYhqC+x70
 1Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791801569; x=1792406369;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FaqkEwa9SJzlxounBdIQKUjQbypNuudMXhqlY7Q9WMI=;
 b=whzva3ltC101nGXfkVSJBTNX4HAcs9Nx6bkbxekT32BwvYvIITfSjEhYjX/H8qEhyU
 wZTKCOAtMX1/z+ofqYMhC02EY45MpT3XFPixKu2HuW7qbND91gGces06FNgORmu+AMNz
 LttcroH6RF1PVM9sWnHfhvtPWyZWI956jzoDWZJZftcCLe+VV6R/zo6iE6zAHowVfveS
 JhiuwVXTIvCzb0ngBGbOvYNMWvlYFvPQZAYyrRa2/PgicB10ZxfIXtkxTlTE0N3gMwiF
 ruVkT/nW5P/IvQcxVTc1pj2uiKtz5vAsmDxlJNEVb58GqmQZf/o5JvHSW5JEH6r+udqI
 9KNg==
X-Gm-Message-State: AFq9FYKR1J2RGszRlIZdRcmD9AO/kTAkyQxHHothUW1kjJZ1/na1OpKS
 V9CpH7gEw48AdtIQ4rQzI6kBCR/eBvScxkgXVNHYpgsfEXPETufgpmfB
X-Gm-Gg: AYBFou0012IziY+w3xrK0ym4vZDKxNiIB2k6XvKYp/IGcLlzfl0WWFgHTIILdmQL7q9
 wnHnYev6TwuYxpTLF6EtWjBwK8ZFMYyf6p73tKzpYmVVzLRXu1S02NqwHS3ZCP9XQy8MxPthvO1
 MMK2UGSp+b3npb4YN/8FV0LHy+Ge8Gx3JxJ7CgysmSxeZDmjIQs0323Rc0v+ZM9oYaYzr43Nu1P
 kg1ZY17lOOiCcYWRjrdVo689PBCGBwHrXXq5G3+cKcVrkN/MFnP5BjoBoOSti7k7RbKJZTaaCww
 jBJH2pMYkT7XEH2hoT74N6EJbHIS61e9hz50eah1MkGfqQqrToQEUN/8xzWI48G+3szQzfOUAsP
 2+ylk2jgReDVk6lPElkspn0cmxkzg7csnkNUD4x3PiobKYQL9bzwd4urXvfzEhQxCiyn14Ywu3A
 Rhp6+j47eFs1WQWUnc3V7HExPT39GEZKpooI35Ff7itmY7YjPgGKjZWyHIod02iHEpQSmUndEvL
 Q==
X-Received: by 2002:a17:903:2a85:b0:2e5:cf33:80ca with SMTP id
 d9443c01a7336-2e842e0a5a0mr76560825ad.52.1791801569436; 
 Mon, 12 Oct 2026 03:39:29 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b15f4sm42710515ad.45.2026.10.12.03.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 03:39:28 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] hw/ufs: Add support for REPORT_LUNS SCSI command for
 Well Known LUNs
To: qemu-devel@nongnu.org, dridiha98@gmail.com
Cc: jeuk20.kim@samsung.com, kwolf@redhat.com, hreitz@redhat.com, 
 dridiha <dridiha98@gmail.com>, j-young.choi@samsung.com
In-Reply-To: <20261004125305.99878-1-dridiha98@gmail.com>
References: <20261004125305.99878-1-dridiha98@gmail.com>
Date: Mon, 12 Oct 2026 19:39:18 +0900
Message-Id: <179180155857.207105.13436129983903823549.b4-review@b4>
X-Mailer: b4 0.16.1-dev
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> According to the UFS specification, the REPORT_LUNS SCSI command can query
> Well Known LUNs by setting CDB[2] to 0x01 (select Well Known LUNs) or 0x02
> (select all LUNs).
> 
> Currently, the UFS emulation layer lacks handling for these CDB[2] select
> report values, causing command failures when guests attempt to report Well
> Known LUNs.
> 
> This patch adds support for handling CDB[2] values 0x01 and 0x02 in the
> REPORT_LUNS command, returning the appropriate Well Known LUN descriptors
> in the SCSI response payload.
> 
> Signed-off-by: Hamza Dridi <dridiha98@gmail.com>
> ---
>  hw/ufs/lu.c         | 41 +++++++++++++++++++++++++++++++----------
>  include/block/ufs.h |  3 +++
>  2 files changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/hw/ufs/lu.c b/hw/ufs/lu.c
> index bdb16508512..4d77c2da2fd 100644
> --- a/hw/ufs/lu.c
> +++ b/hw/ufs/lu.c
> @@ -211,33 +211,54 @@ static const struct SCSIBusInfo ufs_scsi_info = {
>      .cancel = ufs_scsi_command_cancelled,
>  };
>  
> +static bool ufs_append_lun(uint8_t *outbuf, uint32_t outbuf_len, int *len,
> +                           uint8_t lun, uint8_t lun_msb)
> +{
> +    if (*len + 8 > outbuf_len) {
> +        return false;
> +    }
> +
> +    memset(outbuf + *len, 0, 8);
> +    outbuf[*len] = lun_msb;
> +    outbuf[*len + 1] = lun;
> +    *len += 8;
> +
> +    return true;
> +}
> +
>  static int ufs_emulate_report_luns(UfsRequest *req, uint8_t *outbuf,
>                                     uint32_t outbuf_len)
>  {
>      UfsHc *u = req->hc;
>      int len = 0;
>  
> -    /* TODO: Support for cases where SELECT REPORT is 1 and 2 */
> -    if (req->req_upiu.sc.cdb[2] != 0) {
> +    uint8_t report_lun_cmd = req->req_upiu.sc.cdb[2];
> +
> +    if (report_lun_cmd > 2) {
>          return SCSI_COMMAND_FAIL;
>      }
>  
>      if (outbuf_len < 8) {
>          return SCSI_COMMAND_FAIL;
>      }
> +
>      memset(outbuf, 0, 8);
>      len += 8;
>  
> -    for (uint8_t lun = 0; lun < UFS_MAX_LUS; ++lun) {
> -        if (u->lus[lun]) {
> -            if (len + 8 > outbuf_len) {
> +    if (report_lun_cmd == 2 || report_lun_cmd == 1) {
> +        ufs_append_lun(outbuf, outbuf_len, &len, u->report_wlu.lun,
> +                       UFS_WLUN_MSB);
> +        ufs_append_lun(outbuf, outbuf_len, &len, u->dev_wlu.lun, UFS_WLUN_MSB);
> +        ufs_append_lun(outbuf, outbuf_len, &len, u->boot_wlu.lun, UFS_WLUN_MSB);
> +        ufs_append_lun(outbuf, outbuf_len, &len, u->rpmb_wlu.lun, UFS_WLUN_MSB);

These values include the UPIU WLUN_ID bit, but REPORT LUNS requires the
SCSI W-LUN value. UFS 4.1 Table 10.65 shows C1 30 for Boot and
C1 44 for RPMB.

I checked SELECT REPORT=1 and 2 on a Samsung KLUEG8UHDB-C2D1 UFS device
and in a Debian guest running the patched QEMU. Both report types returned
the following first two bytes for each WLUN record:

    WLUN          Real device   Patched QEMU
    REPORT LUNS   C1 01         C1 81
    UFS Device    C1 50         C1 D0
    Boot          C1 30         C1 B0
    RPMB          C1 44         C1 C4

The remaining six bytes were zero in both cases. Please clear the UPIU
WLUN_ID bit before writing the W-LUN byte.

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

