Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1CDCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGN-00040B-A9; Thu, 30 Apr 2026 10:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIRRC-0003fR-Vf
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:28:19 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wIRRB-00014G-4n
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:28:18 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-651d692e833so897433d50.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 06:28:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777555696; cv=none;
 d=google.com; s=arc-20240605;
 b=NHonmFgyDx/j4TH6uEIY60C1DUtrk75Y24bPTw/oU2xiNi7O1VX6GrUjn5MFiWH9Y0
 qyylx/9dRysMnujh9h7viRi3U1B7QutK9O3ZZgAT48QRPw8mSYjw2jA23Jar/2FIrHMy
 pdy3Nl2/pQX7lSUO6tUkh65Eif6NTz6FQjGkhqh6UelWrqBAwlAAtodW50+bmWRzgm9m
 Rxu/qEuIX+10f23DZDmV2+43WMC0GkLI7iOWrzaJsPONg4MMgm3wXrQgOr0uf6cLP+RP
 U8gPegBl9AgYZM5tMgdgV+MsI6Z07eVC4Ope0h9uTM6qrFbYUn7F2r9ArHz5/vjtD3oy
 U6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AkotdRa75/QsnNXDPjSrO6zfePlBt8CR6fWk5G2AGHQ=;
 fh=TnDbL9mYH20MplIPRJjnJR4NKrcSt7fGISPEXk7FgyM=;
 b=AJlRVbjO9ZznkzplzEZujy5WkshSz3PE4JqI7j1d5/FaMb42grNDZt8Y3RZgzcC9lv
 0d5PRVMkpNW3oh74L4szLcsSIQ5GonIgE6113BLjcRNzepf12LvMi1I4sMDYCFXP1pX+
 Lbdp9kPRUq/J7VTOT6ch6cu+AP+3Pwmr/xoTTVPtbsOyPguTSoq9CBoqyf84ZeqeHEJ1
 3e4cV8dKOSTLpM8N8GiMp9yfdPAMONImHFRLoXB1zQ58KHGHe90BlhpG4BmRMeePxo2G
 eXiIumOAOoWiwy5RD+GbSnj+q+wVjb3ZQa1MFKTgj0394tphcjOWrHuAr+MM7AwRpcd4
 GzFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777555696; x=1778160496; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AkotdRa75/QsnNXDPjSrO6zfePlBt8CR6fWk5G2AGHQ=;
 b=e5JREhln1ecRZHxyJNcPi7a6wT/+ItT3IJ0lUl3+7Ilrr6YpkeFQ1DLBtl5ku+zpLE
 1UPvpA0usD7YQ8YlCdJtP3vtEOdnupDRER0jtZql+78ajfclS3RflGaW0e/IId1VVd6y
 D3NozpkxzVcR7rB9/coB468ZI8lScU27Y4OBF3GC+gIa/kv8qsuOEjtPwyMhf8jdioCh
 VubaAqvKKsXzLRuGJmfxxyVNR4c6iZ1UaOgbSU/RBR7/VO7qR8eWQ2DfhDupftcloDRl
 wV2tp/g0ZDVpsrByj1Fklab+f+gtI+NR3KVkFMa8bgGa3GVcqEBriqdTMpz9PXx6vaAF
 b9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555696; x=1778160496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkotdRa75/QsnNXDPjSrO6zfePlBt8CR6fWk5G2AGHQ=;
 b=ArdCCw4gdH3Mbo3NQWdmoaeKTCL7Efx/jhYCugPxHKupAoLBhW13e5gYu+ukajCAng
 dgYi2UgIATdtUrLtN1VVW9Mo6cnnDvzm2ZwrbaauXy8qqog8PQ0Uqv6nooaMIhZtgpzJ
 dRNx2BaeyZA4TmcmkNHrl/DEI8DkoHY0gI+5+BdkDMRoPZcgItxX9BhDW3DE7F0N6bjx
 rSwXjORlChkCjVtSPmKPEMq8eMXrIjTq7NJsjkt7/6GAATAkSt/ZIyA0pHfx1Pxuon+R
 eQH3yXIeJapS8aQZqlI3fmazg1w4WAQapI0iqswwAh0xr154qZjAvuAqzQ+pxgITqYDB
 VHUg==
X-Gm-Message-State: AOJu0Yw5CXzU7Mw5jpk2kRoqxHA3vOYMMY53uFY8AfGRYseqJZuySLWx
 h/Oiq0Zog9tnLHbCbFg26j9ZNzjtSJobHciZ++0lG0LU3GwA9T73CbE2uuEVITbqlwrBaUF5Xv1
 BtmGb/ikGJTTZEuxPNMdd2n29clvaAjM5NaezMNz1mg==
X-Gm-Gg: AeBDieuNT9LhgcSWK0YXDAeKtEJ0zUZCJtoBfZmqb7UcxnAS9boQ5kUUUiohZIusUHM
 +wLXSKnotgYsJsqVu4a9kzfSdAc3vhBNjFE8KdSmMexfvji68EGcC0ha+tgiFQENdBTZvwo3jVy
 98Hloj5Eg4+NuatQFpQ1g77j5xIeHX858NizrCSfAKRTtCAhfCejoD0UDf4ROp2apjlUyf0kMwr
 C8uje0KGMPaPB+POUN47i9xRClDO87s9Nn040zEQgxr2WDeLnJFuzIGuzoEJiGHRqWYJGHrVeoq
 /+6BvRif/dWJgUEpiehKRTZip9+lfwWqaLdpr3SQ912O9U61sAEtGy1KRDhkng1nbaWCMYfK3aO
 KGw==
X-Received: by 2002:a05:690e:140f:b0:653:c9e:306 with SMTP id
 956f58d0204a3-65c18cecb05mr2089666d50.20.1777555695666; Thu, 30 Apr 2026
 06:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260429003130.15164-1-farosas@suse.de>
 <20260429003130.15164-2-farosas@suse.de>
In-Reply-To: <20260429003130.15164-2-farosas@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Apr 2026 14:28:02 +0100
X-Gm-Features: AVHnY4Ka6TrjVFLvVXcjeOH8DrPRN51oksEknAA94skS1-7E1eqKgtosPMSgvA0
Message-ID: <CAFEAcA_5hpKE3t07+NqjXWnhwAiRCBugt1DirJ+2-bq4r657jg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] tests/qtest/libqtest: Replace QTEST_TRACE with
 QTEST_QEMU_ARGS
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Wed, 29 Apr 2026 at 01:32, Fabiano Rosas <farosas@suse.de> wrote:
>
> The QTEST_TRACE environment variable allows for any QEMU command line
> option to be passed if used like so:
>
> export QTEST_TRACE="-trace tracepoint -more -opts -here"
>
> Formalize that usage by accepting a new QTEST_QEMU_ARGS
> variable. Since the QTEST_TRACE now becomes redundant, remove its
> usage.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/libqtest.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
> index 051faf31e1..a580d75179 100644
> --- a/tests/qtest/libqtest.c
> +++ b/tests/qtest/libqtest.c
> @@ -454,11 +454,9 @@ gchar *qtest_qemu_args(const char *extra_args)
>  {
>      g_autofree gchar *socket_path = qtest_socket_path("sock");
>      g_autofree gchar *qmp_socket_path = qtest_socket_path("qmp");
> -    const char *trace = g_getenv("QTEST_TRACE");
> -    g_autofree char *tracearg = trace ? g_strdup_printf("-trace %s ", trace) :
> -                                        g_strdup("");
> +    const char *args_from_env = g_getenv("QTEST_QEMU_ARGS");
> +
>      gchar *args = g_strdup_printf(
> -                      "%s"
>                        "-qtest unix:%s "
>                        "-qtest-log %s "
>                        "-chardev socket,path=%s,id=char0 "
> @@ -466,16 +464,17 @@ gchar *qtest_qemu_args(const char *extra_args)
>                        "-display none "
>                        "-audio none "
>                        "%s"
> +                      "%s "
>                        "%s"
>                        " -accel qtest",
>
> -                      tracearg,
>                        socket_path,
>                        getenv("QTEST_LOG") ? DEV_STDERR : DEV_NULL,
>                        qmp_socket_path,
>                        can_exit_with_parent() ?
>                        "-run-with exit-with-parent=on " : "",
> -                      extra_args ?: "");
> +                      extra_args ?: "",
> +                      args_from_env ?: "");

Maybe we should have all those "%s" consistently be "%s "
(and drop the trailing space in the "-run-with exit-with-parent=on "
string and the leading one in " -accel qtest")?

Sometimes we might get an extra space we don't technically
need in the command line, but on the other hand we would be able
to look at the format string and see at a glance that it
definitely doesn't potentially run one argument into the next
without having to cross-check all the %s with the arguments,
and the arguments would consistently always be just strings
with no requirement to bring along a leading or trailing space.

But either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

