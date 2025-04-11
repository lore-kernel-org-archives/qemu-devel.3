Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEB0C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BkO-0006sr-7i; Fri, 11 Apr 2025 06:36:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BkE-0006lH-6f
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:36:23 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BkB-0007c1-EY
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:36:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39c14016868so1552870f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744367778; x=1744972578; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d1zURwIUJy8ZO0ihAOfL1ct7kK2aBaQo6t3eVjDJiMM=;
 b=B5eO0M3vtROzbbxQXYLqe7HIBSgX3aQr7yY8WDPJ/Plfh/WnhldJz2v1OXXZgHe6v8
 R7VXUDwlchys0ZHsgPGKscTyGssDAl611si89NUynbfXublSMfJDuv1bvVhWi5nR0U7P
 xak90LUGt0id1+WVpB9vzvmCxCq3ULMDH92L6pSCS+kcDhkrdHly25pCM0/XSf7OS2F1
 MFS9cBz6WQNGFFSvNFKQ0ejNY1vsxw2gnwXOKTINxc9ajRAfwc7Bo2hRh2xE2ia/0oSX
 7wukCMVQudVNUA5yp0DjYLU++mvfsC/wiRTQ1b1goK4BCOxLl86w9qVzFfjzSeBJ+XNd
 vfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744367778; x=1744972578;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d1zURwIUJy8ZO0ihAOfL1ct7kK2aBaQo6t3eVjDJiMM=;
 b=m/SQb15dZ2TUsaBvF0Png5RE8r3RhrEj/mEh2k4ETeBfBB4SrgUWAdCrQOTGdkb64L
 g90QYDTiQkCCVpAMKGlYtJwlkQ6hDVuSRvyBTW1e1NGMcU0x6Yy3MgRVVCPEv/ywjdYB
 Ig1hGWAS8/RBfsbi96fUtDufjbFa+/QGKkIkMe8g062X9rdD3bXOjJfyvYyX9Opj+u64
 7lVrEd3oWi4ti3MUKQC4xQisxL7HcEAGJmHKH++gcUksas9mLpDp3o28SrAdNAfjl1BZ
 oAE3sKwTVqdfG1xEN4OtRivIaLyWKyikp/yfEgxuKqvsvEkFT78pb/ARutahPJ2E48hB
 oCPA==
X-Gm-Message-State: AOJu0YzrJMVF1gxYGwlkDb06A15dKm5MTHp++022WivcnIzmG4fQTnBT
 ef2X4NtQRT2iap2+glsjLsD+lm9/0VCl4wsk/UoLvnCh/1QX8y60uesiIVet2rc=
X-Gm-Gg: ASbGncuA+1R10dtPpnnLmNnb/9g5ABo5YXMocw7zLs7xD3t8N6HI+NPC6NWNzHVEuVg
 ZgjRDSrg2niN+AzOUtoe3jwKajQMKb/qG3xk3G3HgRvDFUp1ngBECsT9FNMDkZGxgJih0oh7ftF
 xt0k5SaguOEDfjetQHODLkrJtRLLdXQZaGDcU6HUXkrEvwcQzVh0zFa5Sb5xht26T2X8T9oLbed
 CI3HD+B5rZQgu9G/6gzk6WRR5fSpRO86LD5w56iz7sVT48c5rdzp55earZszWiNFxPimSqvd5hk
 1vNzZKgLHBMzeCCJgiTFEfld1UIK4coSu4CdG39iN9x/Y80912YaNuhNIymb0QN1zWymK4HxpV8
 DqBbsIClC
X-Google-Smtp-Source: AGHT+IGBZDk3DKujhzPuh8Cflte4H36J3c1dFiyEbQRXDDacHMnQyByLsAV+dAQwDwBJPgl1iAYc1A==
X-Received: by 2002:a05:6000:2282:b0:39c:30f9:1e57 with SMTP id
 ffacd0b85a97d-39ea5203576mr1728592f8f.18.1744367777667; 
 Fri, 11 Apr 2025 03:36:17 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae979620sm1630362f8f.52.2025.04.11.03.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:36:17 -0700 (PDT)
Message-ID: <5aba881b-a1bb-40fc-b707-2fd0d4b1a1d2@linaro.org>
Date: Fri, 11 Apr 2025 12:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/10] usb/msd: Add more tracing
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-11-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250411080431.207579-11-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/4/25 10:04, Nicholas Piggin wrote:
> Add tracing for more received packet types, cbw_state changes, and
> some more SCSI callbacks. These were useful in debugging relaxed
> packet ordering support.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/usb/dev-storage.c | 23 +++++++++++++++++++++--
>   hw/usb/trace-events  |  9 ++++++++-
>   2 files changed, 29 insertions(+), 3 deletions(-)


>   static void usb_msd_copy_data(MSDState *s, USBPacket *p)
>   {
>       uint32_t len;
> +
>       len = p->iov.size - p->actual_length;
> +
> +    trace_usb_msd_copy_data(s->req->tag, len);
> +
>       if (len > s->scsi_len)
>           len = s->scsi_len;
>       usb_packet_copy(p, scsi_req_get_buf(s->req) + s->scsi_off, len);
> @@ -264,6 +268,8 @@ void usb_msd_transfer_data(SCSIRequest *req, uint32_t len)
>       MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
>       USBPacket *p = s->data_packet;
>   
> +    trace_usb_msd_transfer_data(req->tag, len);
> +
>       if (s->cbw_state == USB_MSD_CBW_DATAIN) {
>           if (req->cmd.mode == SCSI_XFER_TO_DEV) {
>               usb_msd_fatal_error(s);
> @@ -324,11 +330,13 @@ void usb_msd_command_complete(SCSIRequest *req, size_t resid)
>           }
>           if (s->data_len == 0) {
>               s->cbw_state = USB_MSD_CBW_CSW;
> +            trace_usb_msd_cbw_state(s->cbw_state);
>           }
>           /* USB_RET_SUCCESS status clears previous ASYNC status */
>           usb_msd_data_packet_complete(s, USB_RET_SUCCESS);
>       } else if (s->data_len == 0) {
>           s->cbw_state = USB_MSD_CBW_CSW;
> +        trace_usb_msd_cbw_state(s->cbw_state);
>       }

Maybe helpful to log state transition?

   void usb_msd_cbw_change_state(MSDState *s,
                                 enum USBMSDCBWState cbw_state)
   {
       if (s->cbw_state != cbw_state) {
           trace_usb_msd_cbw_state(s->cbw_state, cbw_state);
           s->cbw_state = cbw_state;
       }
   }

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


