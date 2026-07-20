Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D1EC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 08:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wljZI-0006R2-G1; Mon, 20 Jul 2026 04:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljZG-0006BV-8l
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:41:42 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wljZE-0003SW-Cg
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 04:41:42 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-80814edb536so67453167b3.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 01:41:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784536899; cv=none;
 d=google.com; s=arc-20260327;
 b=NJBNNlBqbQklmrbOVOvwRgFl7JrgZ8ZIPmMmdu1j9PQ0UmHPgMosbgtMjSaw7wZUCA
 Bz4r6QwyMZt9SmGqsID2rzc+BoXPRvGTjsh27nDmoPs2rd5iFz+y32eMvyigIEdUUxz2
 /0XiiPxYLWXRBM7RBqHbqSRP/5Tz+II8CxrbrYtmoENkFBjkOgN/cF/TM3O48ZfgUmiT
 5JaG/CtrH65OAEHOftgAHVOY4hVXgWZQ7Sv6US+CddOWwzYnUAJAYtRpa+0TiN+LmpnB
 5kTf3RW8VREx+uJuq8H1Q0yEbSxpTtSo5A5Vr6QGQjrn8RXmM8PZaLph069Ijtrvzq/9
 TuCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EMCFqIk1cvsrPQ6Nv8ZE2kq9WxwWNuFpSUFhPci6Jv0=;
 fh=N98ljGDrl6SjWC3df2+h4NM0iI+rITWAtTHiuzLCNEE=;
 b=BZMqUphELSidHmYXbfjCz0WBO5OsCtaJ1IuvMSCrF3skKN5o++8nSRrjq8IXbdm7A/
 Rmm2qkcxTforfd3thRW9IbKeR6tYWWtA4PN7s2e55n+mvw3UAXbI5ACsGeYC4orul1nm
 zQgzeCOwE0RnvzQKRe1vk6TSlzIQORW1lwL+afJYv5E9P/DLFJnRDa9ZqRDnyqx+Ijvs
 a13+2iWGqgvRb+zuMZMlnSrueaDJ9FkYwClXZVbaq37JJ4g+H/7Zs2gJ0G/xKUR5cz+e
 2cSevLi5MMFfiLdXR8zJPz64L1z8xyx9nxrIzt2aoPTLzOpd2DGcUvx9f55v20Foq1CM
 RGvQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784536899; x=1785141699; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EMCFqIk1cvsrPQ6Nv8ZE2kq9WxwWNuFpSUFhPci6Jv0=;
 b=wRSAfxj78ANVzMwnwMXcLSqwEpknaGFZQGGUAg3fS9DXNULA6xHjKYykm+i8VT1MGd
 oPbkAsSjwEPDtag8HcXP5ZEj6oZ3HRdLWoUgPCZ8DH3cI7K4XVUI5RrvdQljYQTkbCMO
 7U9gRTp+PNXx7T/Fnc4lXGB63fjAHXnowrOp0oK/HtuZvzSYc9qeaKcv8Z9fs8lJvXUW
 HJX+gnDWPGXGKNigCb6VsQtwsRx1yKkMl4XSiVJwp3kem8gfuuqmXrTv5WWdbkbVqHfN
 E17PfVvQ5XdE/k2X95RoVi2nVsG335tfPsIsJdAMPcpwfwoZxqMJdwfYCKYcoC+zLjcw
 edkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784536899; x=1785141699;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EMCFqIk1cvsrPQ6Nv8ZE2kq9WxwWNuFpSUFhPci6Jv0=;
 b=ryVExeNXVcuvYxGWsUES0rj72FBif4qdQFWRevsPYskMEPTR7TTA6EFPQa+WLOlqwv
 sO5U2277b3akSMe8+xQwiSxC5moKxXDam8FtIXBF4vwo/+beiCOQ9VG8bB2yeEY0o8ib
 9NrxUj1YAHfd+p5/GBgKWoiSysxCb0jiXbqOQkPFiQVbKOYg8ctG8yaRmTKmCrW3RxM5
 BFhfYUXgBIhbLPlaqgLWtO9SGXyQ+RAz/x07+VaP75TUhTVUzlRsYIUavypk26Z/aup4
 O6tpl8D3go73rJN9XUVG3qfoZXezF0Icp+fiamNHgay6zi4h6jP8l+w4X/7aH4hRU3E0
 bsEQ==
X-Gm-Message-State: AOJu0YzxskyswLVaPXNgG7pPsjTBnstfoa5SQ6YpDRUSpR8i42qDTNeu
 6z9tZ4UdZiuz/egkite6YK4Kfnj9r6XucobUxhSw6p1lcxu26BtZ3KjK9k1gubtypj+QRs38YhN
 2X3XrFqi83q7qXwBqx+G/0d2i4hAzsyJ+PaVmPIU/30zKvM9XPUjd
X-Gm-Gg: AR+sD13MZ35c//GZWpUEWpdLRMKBIYlCoVoBm5HmVzdaloSPD4BDnVbFUtQ/orEZTjT
 ZKhOWnMZTnI0yXrFB30UNDG2RZ6AJ8DE6DZ3f74J/iWCPGD7B0j8VuWTgeWeUU1ZpFtTlMhJ5nH
 0jR+WVBoiQLZSD0eOrM8LqIjdQQnLY1q0a7Rvf/MwuHmysSQIuiUZV14uhVSkhJP3G+k85ulW19
 ++hpzl1qvDWZgSn25dlLpI37p9tmpg9wJduyFe5TNbDzxdeWMtJDM20s6tTAY+wLQ/wFsyTEWP/
 dU997/5/1WPvkhWdPXnTGfYL+jitViKjkeapjANUtEPZaw==
X-Received: by 2002:a05:690c:3709:b0:81d:26f9:bc85 with SMTP id
 00721157ae682-81ef25e1756mr41486607b3.45.1784536899195; Mon, 20 Jul 2026
 01:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260706162704.787495-1-peter.maydell@linaro.org>
In-Reply-To: <20260706162704.787495-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2026 09:41:26 +0100
X-Gm-Features: AUfX_myPX00TaItZgy2Q7JKw_4KBxQpxvAc2mHEKk2cUYXFtAFhMiv9RGfudYpg
Message-ID: <CAFEAcA_AE+D=3TJ26s7zhvVN_rhak13EJU1Yw-iaahHT83p6Fg@mail.gmail.com>
Subject: Re: [PATCH] hw/net/xilinx_axienet: Don't write checksums off end of
 packet
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

Ping for review, please?

thanks
-- PMM

On Mon, 6 Jul 2026 at 17:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The xilinx_axienet device has ethernet checksum offloading, with a
> mode where the guest provides the offsets within the packet where
> the data to be checksummed starts, and where the final checksum
> should be written into the packet.
>
> We don't sanity check the TX_CSINSERT offset before writing the
> checksum data into it, which means the guest can pass us a value that
> is larger than the packet itself and cause us to write the checksum
> off the end of the buffer.  We also don't explicitly check the
> TX_CSBEGIN offset; this doesn't currently cause any problems because
> we will pass a negative length to net_checksum_add() which does
> nothing, but it's a potential trap for the future if the type
> used for the length gets changed to be unsigned.
>
> Explicitly check the offsets.  The datasheet doesn't say what happens
> if the guest misprograms this, so we choose to log an error and send
> the packet as-is.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3599
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/net/xilinx_axienet.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 970732b162..a44dda5385 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -919,20 +919,27 @@ xilinx_axienet_data_stream_push(StreamSink *obj, uint8_t *buf, size_t size,
>      if (s->hdr[0] & 1) {
>          unsigned int start_off = s->hdr[1] >> 16;
>          unsigned int write_off = s->hdr[1] & 0xffff;
> -        uint32_t tmp_csum;
> -        uint16_t csum;
>
> -        tmp_csum = net_checksum_add(s->txpos - start_off,
> -                                    buf + start_off);
> -        /* Accumulate the seed.  */
> -        tmp_csum += s->hdr[2] & 0xffff;
> +        if (start_off > s->txpos || write_off + 2 > s->txpos) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                          "%s: offsets outside packet, skipping checksum\n",
> +                          TYPE_XILINX_AXI_ENET);
> +        } else {
> +            uint32_t tmp_csum;
> +            uint16_t csum;
>
> -        /* Fold the 32bit partial checksum.  */
> -        csum = net_checksum_finish(tmp_csum);
> +            tmp_csum = net_checksum_add(s->txpos - start_off,
> +                                        buf + start_off);
> +            /* Accumulate the seed.  */
> +            tmp_csum += s->hdr[2] & 0xffff;
>
> -        /* Writeback.  */
> -        buf[write_off] = csum >> 8;
> -        buf[write_off + 1] = csum & 0xff;
> +            /* Fold the 32bit partial checksum.  */
> +            csum = net_checksum_finish(tmp_csum);
> +
> +            /* Writeback.  */
> +            buf[write_off] = csum >> 8;
> +            buf[write_off + 1] = csum & 0xff;
> +        }
>      }
>
>      qemu_send_packet(qemu_get_queue(s->nic), buf, s->txpos);
> --
> 2.43.0

