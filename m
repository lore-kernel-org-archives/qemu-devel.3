Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E7A3FED2F6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 09:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0cRN-0004AX-6H; Thu, 12 Mar 2026 05:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cRC-000498-Oo
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:34:41 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w0cR7-0004ao-PL
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 05:34:36 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-649278a69c5so780243d50.3
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 02:34:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773308072; cv=none;
 d=google.com; s=arc-20240605;
 b=iiz7ph7/0s9Vn9YmuIxlsC9g8m+P767oyzmXwB4b2vthWxeJTH0KUgJlJ/etooa2T4
 vE/JQTnFQIEXnodpw+fZfdiVqT1nkchICCdGgkd1IsNxgXRQuVJbofp9HURC8kinsKQ1
 lwINrGXdrSCSQ4mg49urdowMRMtW6FCKeqcjYhv2Vc7A9zbuWzhKrumMc3STTzMEKT9Y
 4mhNAydsODmwpAlWdjQYNejzfGMKHLcp93GTPE64dt1ISrGJ36E+RflwWlBorNHun4CH
 jnpntEdNDQN8IGkLNuaVVLaZVhUtN4n8Rj0/9w81dYXApdzX6S/+AKqgJw0sFe6ry8Yd
 op5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=OGz4vuz0GsQQ4ZVjL24w4ResPPv8pB+YZm4yNMsfN4E=;
 fh=SVg4ictVTYGlFVdnDFvqsGtiGFrYltina8RE8u43DkU=;
 b=lv+Mx5qfMhWfiSXWAXIzT6FjlFTD8u1ZCe8D5wjQoetfFwSSALuaSl9Mabu4hxwq7w
 ZDHuqYZw/34E3huuFENQcW+PnWLR9R/ZBdlVWRMAnQBaZ8/3YvqHf4fm7Q/jAzDDyc+C
 MjzJMtU74lhYYuLdsAi7ePrHU673sLYn2bZoCqEsNQfA2IoEOwydPVyJe/uE8uz7C31w
 y7vPjgTtjQqPmirpm5fhTUBg/wq0oaEpT9kWJC7S3+Uxe1bsio0Z0yUC2tZ8CF1ZQQAG
 qxqghkAjDHQOi6CxZXpk9iKOd809Bj/F4c8z07HkK/RJtknbPnS1Si0KzgcOKIlHa/SV
 q3Fg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773308072; x=1773912872; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OGz4vuz0GsQQ4ZVjL24w4ResPPv8pB+YZm4yNMsfN4E=;
 b=XapEu3kM+0x0Mz4IAv1WjQNkUiVvgi1paoCt3yzTSh0vZ8A61xehK74nBgx4rHo+GO
 JPZje2+n2PWMvs+2xvsd2TaAQdVytssgNUL22mih1DLV/PqcvYYUMMuZBNw7B7FU9+ME
 72j9M7Mz+WntIQN17XWv3N0m9ygQ/tKSggfgYuIbrex3Dt52ZPLjOw/+yWCWAbi1v7z9
 fn3Y0B4k1CtvoP5fr0VA6JAWBHG1YVJN47XE7/L99LIHIWWsDVa8zdmV6mb6MjNaQGXR
 ZchRgggIDJioZDwzxtF526VMzcAXITGzsfqAFIROxTZ7X8RHKtzhiMTyqDm/h3hbSNfM
 5WQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773308072; x=1773912872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OGz4vuz0GsQQ4ZVjL24w4ResPPv8pB+YZm4yNMsfN4E=;
 b=fvdAcqa3I91IZnfQdR4HW14cV6UPOEmfO8NBUR8FpoGZQJIu672j6zPK7XgPdoYjUN
 kFutKnlNUbg0dFi/bJSKK2eUEkJABCYP61qSI8pjyDoxAUOGA+dKnWs0wmZgeA1ApIEr
 BwbU87EbRpAylrXl7KYgbFAWsDqre8AMPRT3OBBYlu/gOayKodte/X9GCB43lmgvkdfI
 pbw8e68EqHFSe5D5h1ASiynh2eMmYoEgu4F3BB8la2PZ9GwHhiao55Ys+gUJV2h89Zg0
 GtCq3r5X1xlZhpdPL/0OHy2V2cD6GAI/7VkA1k2meJHiybKb9YhSOw/pEI/X/cdHEoDv
 ETpA==
X-Gm-Message-State: AOJu0YyMKoWDZTrSmiG/XrnkC6yPbNDHcMCwHjXFTFSFueSXBEyQNzLF
 XeEJqh9Twh5/cTBwmhui4P5S41ZQ/A210H57RZTtxtgVs05Z0tgwZuyVES8V48UuhCWwfWFeVgo
 VtBrZV+N28rnBDP8EHNaNrBnnnIWRBxiK46drmqPiXw==
X-Gm-Gg: ATEYQzzoy2PYhtGzFHN7oYn//ISYj43jmbfyYKNHDGKHdXpS7cmHbbfDpgeTzDR24uY
 dqpM3fwAxbU0doSvTu+vaP4sWHHkOOgrAQ/zM1y79BKm8rrWADNfedw3y2c6VSsCmZj87wqDYhP
 tb9JembiCh/q5+ALvi1gW+bEJFr6r9RiJ50qZIzsYubhwG4gYQQOkCkXHVoW4+E0sRS5bzmxMmp
 UhLjZN3mEchIPLxdBBpT48YhDkbGLgpemxTzTyGkkDw2oU6tZstvOsiyLSg2gsZ2G403diAznAg
 ovyqmQVmBisSdw7tlcK+PfEXe0pAUTCbhe6CHwJ2KOPCJFZnX7nD/8ehTwQH/n8uDSI=
X-Received: by 2002:a53:ac94:0:b0:64c:b7c9:dffd with SMTP id
 956f58d0204a3-64d657857e8mr5197406d50.58.1773308072359; Thu, 12 Mar 2026
 02:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260312085220.194207-1-vikingtc4@gmail.com>
In-Reply-To: <20260312085220.194207-1-vikingtc4@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Mar 2026 09:34:21 +0000
X-Gm-Features: AaiRm53sZiF4soqAR4t-FQ7Ffv9PJtXTQOIuaksw57zdQoBdYhjVYFHHwQIfR8c
Message-ID: <CAFEAcA9SxRVkosA0HMfomLKAVxHki4xOR-LyLWAFEn24K56mMg@mail.gmail.com>
Subject: Re: [PATCH] block/curl: Fix Resource Leak in curl_header_cb
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com, 
 qemu-block@nongnu.org, "trieu2.huynh" <trieu2.huynh@lge.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 12 Mar 2026 at 08:53, Trieu Huynh <vikingtc4@gmail.com> wrote:
>
> From: "trieu2.huynh" <trieu2.huynh@lge.com>
>
> The function curl_header_cb uses g_autofree with g_strstrip(g_strndup(...)).
> However, g_strstrip may return a pointer that is an offset from the
> original allocated memory, causing g_autofree to attempt to free
> an invalid pointer or leak the original.

I don't believe this is correct. g_strstrip() will
always return the string argument it is passed. (The glib
documentation for g_strstrip() doesn't say so explicitly, but
it is a macro for g_strchomp(g_strchug(string)), and both
those functions say that they return the input argmuent.)

> Separate the allocation and the stripping to ensure the original
> pointer is correctly tracked and freed.
>
> Resolves: CID 1645633
>
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>
> ---
>  block/curl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/block/curl.c b/block/curl.c
> index 66aecfb20e..5b66c80704 100644
> --- a/block/curl.c
> +++ b/block/curl.c
> @@ -208,7 +208,8 @@ static size_t curl_header_cb(void *ptr, size_t size, size_t nmemb, void *opaque)
>  {
>      BDRVCURLState *s = opaque;
>      size_t realsize = size * nmemb;
> -    g_autofree char *header = g_strstrip(g_strndup(ptr, realsize));
> +    g_autofree char *header = g_strndup(ptr, realsize);
> +    g_strstrip(header);

Being able to rewrite the code like this confirms that we
don't actually have a leak -- we are still relying here on
g_strstrip(X) == X, just in a different way.

>      char *val = strchr(header, ':');
>
>      if (!val) {

This looks like a Coverity false positive to me, so I've marked it
that way in the Coverity Scan UI.

thanks
-- PMM

