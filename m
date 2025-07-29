Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E17C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 14:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugkyM-0002tT-DV; Tue, 29 Jul 2025 10:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ugkyB-0002Dd-C2; Tue, 29 Jul 2025 10:06:23 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1ugky8-0000iz-Mi; Tue, 29 Jul 2025 10:06:18 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-748f5a4a423so3904615b3a.1; 
 Tue, 29 Jul 2025 07:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753797972; x=1754402772; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9+s9a0j2kEOWZs6Rv8r9dOEb1iz46PG4C67n40F6x+g=;
 b=JpxcgdeP8Xd3M4N2U0rXi1Dg+ofehb555fv8ZPWLY0yItlsInjhf13KpSxoCbE/MdM
 qlruLrQg43jcZ55ninZ+3aTT/LKbq1tznUyLsLQ6TAMUiCYeqLjVLxPXRZY/o5lpZGa7
 6Med5LKQITKbIcZWmTE0mN1OWcrWbeTi8WljpPodbIlNpxdpFehn2TYxkqp93+qaDreq
 AjZzjoMK9m4F2tMN8AEi6VywxDr1AqjtEGxZDRWigbrfgcwYHe1TFri566BgvevUTDW5
 KllxDkMa6lhDwDZuusKV8G+QafK18lg0ZDsoXvFGdOdf5MW5S9VM+EBsq8pRNBAC3c2h
 8szQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753797972; x=1754402772;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9+s9a0j2kEOWZs6Rv8r9dOEb1iz46PG4C67n40F6x+g=;
 b=RdTwyNdY7lDwC5xpIaXPmlC49JPW9ZfUtYtjO+mm39KsAAx5guhNlf6xgtzA+Qdg5Q
 mzaI/CLcKmcb2sp8yijtvESjb5wp9ef1uY4cbDlX8SuNXZPsIx6ZqGlHcMiJsuP+/XNH
 o7XxXBBOrfY9aOl9KBe7VPwuATNNSzz79JpfVNYmpHs9oerSQJ85dhaZmqcKWm5tLLt/
 mMLLQRvYKzm04MCjZn+0cCgDn4aJObxs6X9Y2GkG7/VoQSg+Q6LrKy4458aePwlmWKc7
 oxu299gzt8xxCD198OHbVqVD3TLYWOwvqU7s+7/RoLdSnhCEb7gKtq08vjvbHhP83yXc
 ptuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUko9RAQo3iV/QY7Arkv/W7c6mW32wDTCDW+mPaEaDWm8Q6Y9LtiIwqpb9P2JdbrSsSc5mI/r7lONsgg==@nongnu.org,
 AJvYcCVbqfedHzbACXsOnCwj5NnwSaefH5NY28C0fmVTs3ZTlatPOJF1bMwW9UlrH/j/PfWLtnAseaT7Lxfz@nongnu.org
X-Gm-Message-State: AOJu0YyZVqtOP5jgaYAFCJx29S8gi6FitewTpP9cDUdWsDPhxRGYA1co
 okEaqrMcQ4N9tGYtKaGusiO/6dv+HU/86Lj90/OGynr2CPuqVMwS4ddU
X-Gm-Gg: ASbGncukHGKx2gNxKRsbMHu0lvlV9QKM9FiLjsZbEXd0RyPq8liTZW2f4MFEe/A0+4+
 aoS6roblrLjDsCvJbV89Do7zfAK3gXMVQ2KUGW6vA297cDzgc8LnkJ4CnwNZghDqTrWoqUcXlGc
 V7t4VT4gPklAH8pDOrT1ZQLdn38byxyITVvDCglQiKoLz+yOwJXml7zpOPSfHMl0B25F7NFLl/i
 nvJJWFBdr4X5FGIrwnlRlab9RQfCvD5DtqariOqB0TOTLAoe2ZWKMbOCaLh0A1rLPfDzpXSdXSE
 Fat8gbwv/3YdISS+TerrUyyTBfnlDK15Zgx+ZIODWFK4ixC+Rxk76d5TQPdo3oyYisiWWwhRLtx
 xAsMX09/DQPFvTnODXWpawbRUzWItsihbLBDIhCEcdUj9pQ==
X-Google-Smtp-Source: AGHT+IFbCMvW+NtIodS5Ur2FyH8dcMo3suXeKp9sy/XkFTzkfd3iQDMUuSLzf7mtnJB3E/c3lLnlMw==
X-Received: by 2002:a05:6a00:1988:b0:74e:aa6f:eae1 with SMTP id
 d2e1a72fcca58-7633583025cmr21261728b3a.14.1753797972080; 
 Tue, 29 Jul 2025 07:06:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76a00902a50sm1583791b3a.79.2025.07.29.07.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 07:06:11 -0700 (PDT)
Date: Tue, 29 Jul 2025 07:06:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, qemu-block@nongnu.org,
 bmeng.cn@gmail.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/sd/sdcard: fix spi_cmd_SEND_CSD/CID state check
Message-ID: <e8d7ef85-7c6c-4769-a6ae-9e1cb5ffe260@roeck-us.net>
References: <20250724105807.697915-1-ben.dooks@codethink.co.uk>
 <893a7943-e5ac-4c42-b30f-1dfa262b923e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <893a7943-e5ac-4c42-b30f-1dfa262b923e@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x432.google.com
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

On Tue, Jul 29, 2025 at 03:51:33PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Ben,
> 
> On 24/7/25 12:58, Ben Dooks wrote:
> > The addition of specific handlers for mmc-spi for SEND_CSD and
> > SEND_CID has broken at least Linux and possibly also u-boot's
> > mmc-spi code.
> > 
> > It looks like when adding the code, it is checking for these
> > commands to not be in sd_standby_state but the check looks to
> > have been accidentally reversed (see below)
> > 
> >       if (sd->state != sd_standby_state) {
> >           return sd_invalid_state_for_cmd(sd, req);
> >       }
> > 
> > Linux shows the following:
> > 
> > [    0.293983] Waiting for root device /dev/mmcblk0...
> > [    1.363071] mmc0: error -38 whilst initialising SD card
> > [    2.418566] mmc0: error -38 whilst initialising SD card
> > 
> > Fixes: da954d0e32444f122a4 ("hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)")
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> >   hw/sd/sd.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index 49fc79cf8a..e6c1ba7c5d 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -1317,7 +1317,7 @@ static sd_rsp_type_t sd_cmd_SEND_IF_COND(SDState *sd, SDRequest req)
> >   /* CMD9 */
> >   static sd_rsp_type_t spi_cmd_SEND_CSD(SDState *sd, SDRequest req)
> >   {
> > -    if (sd->state != sd_standby_state) {
> > +    if (sd->state == sd_standby_state) {
> 
> This happens to work in your case by luck.
> 
> Since we switch to sd_sendingdata_state in sd_cmd_to_sendingdata(),
> we need to check for sd_transfer_state -- the spec is wrong here! --.
> 
> Btw sd_cmd_to_sendingdata() already checks for that.
> 

In my fix (the one I am carrying downstream) I have

-    if (sd->state != sd_standby_state) {
+    if (sd->state != sd_transfer_state) {

in spi_cmd_SEND_CSD() and spi_cmd_SEND_CID(), together with

-        return sd_r2_s;
+        return sd_r1;

in sd_cmd_SEND_STATUS().

Guenter

