Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20BBCCD185
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 13:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6qkz-0002og-7Z; Thu, 09 Oct 2025 09:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v6qkw-0002nr-8V
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:32:30 -0400
Received: from mail-yx1-xb12d.google.com ([2607:f8b0:4864:20::b12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v6qkj-0003Kr-M5
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 09:32:28 -0400
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-63497c2a27dso1002799d50.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 06:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760016731; x=1760621531; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tUj8sV+Fgo8Ban9njb2D8BBwZZzojvQOYNXH7K/xy0=;
 b=deLqNMwunIYoatySBBk7H824G7FZ37V9At7A7jz4LcA/Wt37Es1/91njQ+Z/z5I9Ro
 YgMsJLGjc+8qie6rw4m6AZZc7kdr9w14ucRJDgdbjV56OvWBfzUrkXL8zPrG4nQXwxSF
 JWHAZfCeaHUCSagN098v/3K9EK/w50aicok7LnV6kd6JHuOFnjxgQBd2tBYTqUmQghgq
 b9CWpt320IWooeFFxk0U3rH1SQqh8CFR3caVmyi/cfKBtqrx5zp9QYxjyamQH/pEBwcl
 ncskqOqpGIeo48ckQbrI06wLXnh3CeG8DG6HwoJiN6qD9ZmUIF5VaSpCe7chB42JQhUy
 byFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760016731; x=1760621531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tUj8sV+Fgo8Ban9njb2D8BBwZZzojvQOYNXH7K/xy0=;
 b=No1309bZucmTCUyQ5+6Z+m4mm64WdBQYLLjQnjk/Y6VV4TBw/S8sHvHlJ+6tN6l01A
 6BlSn3xXebFwKMcQRt8V9FinyQLwdMvs/xvzqkCehWAqkU3k8wAKxJofMT+HJrmQCtYo
 fuQQY8/gBObSnM5ei4rym6zeSAnp2lOcKAFoS9yD1zNK827qgjF9GIxZqbl759Tx4hfJ
 ZGwhCz7DCEJG4lpOjDuvWIh9k2QQRGUlbqojErQKN5CaGbCDa65B9I4nJ3jPkSFyo5Ky
 3HSdN2mQOL2Yzjl2kvfwvq1+J3MCPqnojvAWFK2yycNCzvdeYpxdPTUsjWYyPr+qzf5Y
 vdNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyfp20gNsoR0XGebTedJuihTIiDTdlry+J6LZSJVLNZLcVYNuWabYhGwEtjcZ5yE7WRVRihgVMhM1w@nongnu.org
X-Gm-Message-State: AOJu0YwHQP1F2EyDex5GC3ApuC7Eq5IYls18BAAMhNaCGxRcEPJQIEgb
 eAbIVS2DU3P78WBDM11cASEYvlRdjBQkJNBFUc4PmBcEoxcIHRZKQsdgiRj7+aJ8SJXLabxiEpM
 8g7e6rzm3TB80E/QOQcrdOQOQev8oY8vvGirQtGHCZg==
X-Gm-Gg: ASbGncuNIu6FAMMlSIwzZpT7ZznMMbflyyuAK+bES7rUjlJ9Nix8gSZvYcFCfnmPRmO
 5R/4Zii4SwYu/jiS0xgL8AGp5KPQ4adqEZwmmfpNcRyyF7N1iDBlIqOToqg2GSyXscGXL19fUSU
 PFQF4nDw0SD504VxtRzzTNXfy8IiY8gd4IzT9qEfj0c9QGSo7CVH6X9y5PAlX8SDpkkSlRtPjuf
 llqo+QnmNltw6ghRvdODq51zLchjyXQ3/DNo2KG0dFxXv4=
X-Google-Smtp-Source: AGHT+IFpKDUk6bwsQSQeXG6gw1gCwlKSLG+fhOZCowDDLRnLM9Xe2KQhSjrIiizaDvoLy9wKZCRpf5hudBjy7/2RfqA=
X-Received: by 2002:a05:690c:64c8:b0:766:6507:686b with SMTP id
 00721157ae682-780e1520680mr119740827b3.8.1760016731612; Thu, 09 Oct 2025
 06:32:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251009070010.1863345-1-maochenxi@bosc.ac.cn>
In-Reply-To: <20251009070010.1863345-1-maochenxi@bosc.ac.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Oct 2025 14:32:00 +0100
X-Gm-Features: AS18NWC12v9CuMqpDmMhtLetme-khdndvqQydXbeqFUxt6tqGitcgzDMJ92IkUg
Message-ID: <CAFEAcA9oHpFmxmWV6dwVsQdJ6=_fKUrB4coD8m-QNi_KMMgSfg@mail.gmail.com>
Subject: Re: [PATCH v1] Fix build break when LTO is enabled
To: Chenxi Mao <maochenxi@bosc.ac.cn>
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 9 Oct 2025 at 14:15, Chenxi Mao <maochenxi@bosc.ac.cn> wrote:
>
> QEMU build fails when LTO is enabled:
> ../configure --target-list=3Driscv64-softmmu --enable-lto
> make
>
> Several errors occur due to incorrect curl_easy_setopt usage:
>
> ../contrib/elf2dmp/download.c:30:16: error: call to =E2=80=98_curl_easy_s=
etopt_err_long=E2=80=99 declared with attribute warning: curl_easy_setopt e=
xpects a long argument [-Werror=3Dattribute-warning]
>    30 |             || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1) =
!=3D CURLE_OK
>       |                ^
> lto1: all warnings being treated as errors
> ../block/curl.c: In function =E2=80=98curl_open=E2=80=99:
> ../block/curl.c:806:9: error: call to =E2=80=98_curl_easy_setopt_err_long=
=E2=80=99 declared with attribute warning: curl_easy_setopt expects a long =
argument [-Werror=3Dattribute-warning]
>   806 |     if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1) ||
>       |         ^
> lto1: all warnings being treated as errors
>
> The third parameter of curl_easy_setopt should be of long type.
> Change integer constants to long by adding 'L' suffix.
>
> After this change, build passes and runs without errors.
>
> Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>

Hi; there's already a patch on list for this:

https://patchew.org/QEMU/20251001124055.2743244-1-rjones@redhat.com/

Looks like that missed the elf2dmp usage though:

> diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
> index 21306b3fd4..fa8da0f9a2 100644
> --- a/contrib/elf2dmp/download.c
> +++ b/contrib/elf2dmp/download.c
> @@ -27,8 +27,8 @@ bool download_url(const char *name, const char *url)
>      if (curl_easy_setopt(curl, CURLOPT_URL, url) !=3D CURLE_OK
>              || curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, NULL) !=3D =
CURLE_OK
>              || curl_easy_setopt(curl, CURLOPT_WRITEDATA, file) !=3D CURL=
E_OK
> -            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1) !=3D CU=
RLE_OK
> -            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0) !=3D CURLE_=
OK
> +            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) !=3D C=
URLE_OK
> +            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L) !=3D CURLE=
_OK
>              || curl_easy_perform(curl) !=3D CURLE_OK) {
>          unlink(name);
>          fclose(file);


thanks
-- PMM

