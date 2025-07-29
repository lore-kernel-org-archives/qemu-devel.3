Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEC2C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 17:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugnpN-0008Gl-OK; Tue, 29 Jul 2025 13:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ugnIy-0002y5-RF; Tue, 29 Jul 2025 12:36:14 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ugnIw-0003rq-3r; Tue, 29 Jul 2025 12:35:56 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-b42099901baso1670251a12.2; 
 Tue, 29 Jul 2025 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753806945; x=1754411745; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mMV0JA7tv2P0CyRV1JOr65kw6sQuWnvjYmaJLX0wPac=;
 b=jho0tKUQ+tT7xNuK21kJh0tQZd0VWRfOwIxxkWYOg5ZMj9cpp8Bvx/F60h8QoWQJ3b
 xoDVcjJt1YtZnDp3GXWEfXvkpMaPbfiNuY7EVifOmhOTtBW/v2DrtyS3eQHYi41X6s+V
 dpOCtUqtG3l13Zyftl0sLRmoU3qQjbWlMgj6aRAVxqomj3pYtln0GYY9GVdpDnMt3mdG
 6SVr5jiSX/ZUTc4p56IDfI6MVZd7Ps/Snk6GynhCLqCLFdnmrBLeNEoyU2K+VKAHPrGv
 ChoePKuTw7990mMrqoPmJtSLPB712hyG9UV1L9oIzp5D9Y5JzjtK4qxH3uv/52LrOQvL
 XShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753806945; x=1754411745;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mMV0JA7tv2P0CyRV1JOr65kw6sQuWnvjYmaJLX0wPac=;
 b=CQanY48g4t2lFJ4LfyF9ag5xm6cWLY4ev0ytF/BeDIIhmhjkdrp4fRJa1QKQqZbTTW
 +qkWKAd0eSSNSPRMU3FMjoSfX7MzOhRlUjxiR9+5Cga96PUTJIOPQgoxDi/yb1gZ/MG2
 2dkjKVA3nP7Lv4k2FP05J8eSk7GKZQYiYQ1qRZ0sT13h+Ew0dbrzDHN5cb+FpP93mKqw
 qSusPh1a8yBXOyvhHcRZ4kFU8zaits2htgKgw1rc3/voJ30S1SZUGDA1fStdfPq67nQ4
 KWyr3A1GydsfQ0jDzSRVTXyCCrhONDPme+yOEdfgIUP8T2aXgQsdHBv8Gp04VhDyMDuh
 MIZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaGS7LjsvxZwR34/wohqC/J3nUwrIDWjhX82D/T2HtLBw4UO3+oORvZAXhpjA/WPTxdK9oaVPl+jk3@nongnu.org,
 AJvYcCX16bil2u8TqHeIk+I3H72ftHFTTpvwm3UeF+Fs1qdXwv0V1cXtTADHgWHBa0KYcCuYT9TE8AMX2vQUtQ==@nongnu.org
X-Gm-Message-State: AOJu0YwgzEbyTejwiEgZfAZExdfGxH9xCky+qeuR9qLA+o8vnahh9yen
 mC5OaQ2jJAN4YrH25o57gjBtdgh/4Ij6eM8j3qhYmTM9r93XGuNHzr2UNFZXgQ==
X-Gm-Gg: ASbGncthG835OnrDNIbhwYTvlJU83IVAh6ZnaDxmdjiWx5A1iqydae335kmG0+RqJBa
 jMW8DiuKTkdo1LRnLxP7ivd2HjRkM0/hD35AfC4jYVim9lvTJpRmDREkfK8F9H4ISKaZNfATbh8
 y/4iF5tIEBREdaKvG9+6alGrVJd/7v1AQmvGTISRQZ6IY8z1D+AHl1Bd6/MEpIOYmKIkSSddRFy
 +uSqE9SkkeoaWewNcb9Nb2eDd/iH4A0DQ6syhCAaBq7zo9B7vzNAXeOAuFf8t/9aBY25up4puXJ
 uOjpOzZCcTehqOWlqD8nbKaD+CVsUlZaxeO7biFxJcpZEc+F3ZMNAhK6LxKR4Bn+SrsL9+w5z1x
 KallSq3jP7To9f+ogg4UoacaiOTljTidIXT5wLEQkk7pAvw==
X-Google-Smtp-Source: AGHT+IFtTOrk7OrmP3zKrQeRKUAspSn8u7GuU+Z3sUF85zl5GStBce+7vsg1QTBm8t5zP1UHsu91iw==
X-Received: by 2002:a17:90a:e703:b0:313:f83a:e473 with SMTP id
 98e67ed59e1d1-31f5de16a31mr234631a91.15.1753806944440; 
 Tue, 29 Jul 2025 09:35:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f2efd94absm1152002a91.1.2025.07.29.09.35.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:35:43 -0700 (PDT)
Date: Tue, 29 Jul 2025 09:35:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, bmeng.cn@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/sd/sdcard: fix spi_cmd_SEND_CSD/CID state check
Message-ID: <b89e76f3-9a9b-4d7f-aafd-2c00959c8321@roeck-us.net>
References: <20250724105807.697915-1-ben.dooks@codethink.co.uk>
 <893a7943-e5ac-4c42-b30f-1dfa262b923e@linaro.org>
 <7731f31b606442cab7a3f7b1c2cf6d6e@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7731f31b606442cab7a3f7b1c2cf6d6e@codethink.co.uk>
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 29, 2025 at 04:06:33PM +0100, Ben Dooks wrote:
> 
> 
> On 2025-07-29 14:51, Philippe Mathieu-Daudé wrote:
> > Hi Ben,
> > 
> > On 24/7/25 12:58, Ben Dooks wrote:
> > > The addition of specific handlers for mmc-spi for SEND_CSD and
> > > SEND_CID has broken at least Linux and possibly also u-boot's
> > > mmc-spi code.
> > > 
> > > It looks like when adding the code, it is checking for these
> > > commands to not be in sd_standby_state but the check looks to
> > > have been accidentally reversed (see below)
> > > 
> > >       if (sd->state != sd_standby_state) {
> > >           return sd_invalid_state_for_cmd(sd, req);
> > >       }
> > > 
> > > Linux shows the following:
> > > 
> > > [    0.293983] Waiting for root device /dev/mmcblk0...
> > > [    1.363071] mmc0: error -38 whilst initialising SD card
> > > [    2.418566] mmc0: error -38 whilst initialising SD card
> > > 
> > > Fixes: da954d0e32444f122a4 ("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID
> > > handlers (CMD9 & CMD10)")
> > > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > > ---
> > >   hw/sd/sd.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
...
> 
> ok, so what is the correct fix? the sd-spi has been broken for some time.
> 

FWIW, I use the patch below on top of upstream qemu. I have no idea if it
is correct, but it fixes the problem for me.

Guenter

---
From 87a2004005eb47758c524b54dd3fbc68a00e317f Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 24 Oct 2024 12:16:44 -0700
Subject: [PATCH] sd: Fix boot failures seen on sifive_u

sifive_u fails to boot from SD. This patch fixes the problem.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 hw/sd/sd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index c275fdda2d..f5c44a4a86 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1520,7 +1520,7 @@ static sd_rsp_type_t emmc_cmd_SEND_EXT_CSD(SDState *sd, SDRequest req)
 /* CMD9 */
 static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_standby_state) {
+    if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
     return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
@@ -1539,7 +1539,7 @@ static sd_rsp_type_t sd_cmd_SEND_CSD(SDState *sd, SDRequest req)
 /* CMD10 */
 static sd_rsp_type_t spi_cmd_SEND_CID(SDState *sd, SDRequest req)
 {
-    if (sd->state != sd_standby_state) {
+    if (sd->state != sd_transfer_state) {
         return sd_invalid_state_for_cmd(sd, req);
     }
     return sd_cmd_to_sendingdata(sd, req, sd_req_get_address(sd, req),
@@ -1592,7 +1592,7 @@ static sd_rsp_type_t sd_cmd_SEND_STATUS(SDState *sd, SDRequest req)
     }
 
     if (sd_is_spi(sd)) {
-        return sd_r2_s;
+        return sd_r1;
     }
 
     return sd_req_rca_same(sd, req) ? sd_r1 : sd_r0;
-- 
2.45.2


