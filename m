Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB798C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 05:46:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHykm-0000Qf-6l; Thu, 22 May 2025 01:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHyki-0000QA-Ju
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:46:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uHykf-0003uI-Iw
 for qemu-devel@nongnu.org; Thu, 22 May 2025 01:46:00 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7376e311086so9007722b3a.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 22:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1747892756; x=1748497556;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vridlo6qQCo3NODDccBj5zdty2ixnQZBJifxBZfzpAM=;
 b=uLuR46WgzQIcwjnrbUCCDbANgTKW4R7haOdHNrx5fUMZmAMoKI9KS30SNwzgJsGIlP
 kDdghi8Ey7gcfjvx1UoIUhhyGDJJ4H9DXCgdO7wNyE76g3LiEmVdA1DkPcHUY4oJEy/W
 f6HjIexqMqYHnkakqLmkEY2EpJcjEtRMCiPQ4/VUXn+chC/dKoYwPaAIGP+IDk4jomn4
 /b7lLJ1qalrD0RnZiB+I/hGvq1oWaQ8J1DuPhe/vc47BWuJ4OACItVktQ73szT+EFpec
 jtqrDFTvB/zuiDFQyQR+T4y+z6tsKwLOBILRmJ8iafITtXQHVR0x00W2kcLawwYpHt2a
 Ij/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747892756; x=1748497556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vridlo6qQCo3NODDccBj5zdty2ixnQZBJifxBZfzpAM=;
 b=vnCHReGXnZF+RVeMOTBVFZC+ttzNCx2AoICJTiK0OZ9HOLk0aqwNBXUvZwawiquvYd
 +9RlU22JHAR/rhTIwIkswUyovvxRPU2FhbKE3kry1IRhAYvOm6xVmzS82qnSRegzK0id
 REDyX6J4OQ8BLjjGSJrqNjsz9b2NU8rtsfoC+VMwTKbr7bPCYvnD6oXdyJ8wmM7LtySg
 hQv0YVBSedv1GOpuDsVFu4WDECvYa1+77hK3R2flm3/1tuR30VdLfRwoxgkmJLyUByks
 IHUfDjpkugjduK9GV8FkxpD9KntRea59hFqCYhKb+GJRnlHmz4umkSeTSDirgNJnD1yI
 Zacw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOGRJ9wIrYJWfIaa+EpX6a8WMC9vIYTW1Bt8i5kqqPxbh9kmK0tvrezipjCHXyPiRWKkGS57/hL9b3@nongnu.org
X-Gm-Message-State: AOJu0YyTIW5ldgo4BXOQ2FbKAzlKcH5EfDEHYydq255SSkz5b8HaYaqv
 w8WWlQgyWOTuB4Q91icJ2Fz+3WTPNZepF/B2ebCGmU0cFPXT03SoO6Tj49HtyUdPAf0=
X-Gm-Gg: ASbGncuYlUU7oxgAfDFaij5oCA74I+XVPgHfqoIwDLGHLDXc+fYEbO46ElWDUQEPyKh
 cSCpv5k+OhP/bWGjESR94xaYWSeOGABbzIlV4z9Zg0iHAzIfNFO5s5LEbM1jLwTK/n/QKpGNwrM
 V2X5K14sxtphy6e/WUhqcd+ZIvz63xNJh/aFQpkur9VaMx/kq2TOzCvItSXa7/vBxMrGxElCwM6
 i8uLloUoKNEMCJK63jbJTrlUmSmEcouXDt63hJv/uGp77FRiRIm3jxJZevlOzh+21gi7Zaa1cDZ
 cmdnjf6+GonMrAEetXBxuQK31IP9B40wVEYM2OMhXKTYSJd8EgJe/NK54e3CaQ==
X-Google-Smtp-Source: AGHT+IHnDxQBWkuSpF23l+n5qWSU7kgnedR8lLOx4kEnAuPmd7bVoid4joG8z8ac/0StnzDG1A9SJg==
X-Received: by 2002:a05:6a20:2595:b0:1f5:64fd:68ea with SMTP id
 adf61e73a8af0-21621882852mr36594161637.4.1747892756011; 
 Wed, 21 May 2025 22:45:56 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a97398ecsm10472562b3a.79.2025.05.21.22.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 May 2025 22:45:55 -0700 (PDT)
Message-ID: <2aece273-04e9-48ee-aa97-dfe1d8c0d6d8@daynix.com>
Date: Thu, 22 May 2025 14:45:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/20] contrib/plugins: add a scaling factor to the ips
 arg
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-8-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250521164250.135776-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/22 1:42, Alex Bennée wrote:
> It's easy to get lost in zeros while setting the numbers of
> instructions per second. Add a scaling suffix to make things simpler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> ---
> v2
>    - normalise the suffix before a full strcmp0
>    - check endptr actually set
>    - fix checkpatch
>    - scale_entry -> ScaleEntry
>    - drop hz from suffix
> ---
>   contrib/plugins/ips.c | 34 +++++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
> index e5297dbb01..eb4418c25b 100644
> --- a/contrib/plugins/ips.c
> +++ b/contrib/plugins/ips.c
> @@ -129,6 +129,18 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
>       qemu_plugin_scoreboard_free(vcpus);
>   }
>   
> +typedef struct {
> +    const char *suffix;
> +    unsigned long multipler;

As I suggested for the previous version, let's use uint32_t or uint64_t.

> +} ScaleEntry;
> +
> +/* a bit like units.h but not binary */
> +static ScaleEntry scales[] = {
> +    { "k", 1000 },
> +    { "m", 1000 * 1000 },
> +    { "g", 1000 * 1000 * 1000 },
> +};
> +
>   QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                              const qemu_info_t *info, int argc,
>                                              char **argv)
> @@ -137,12 +149,32 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>           char *opt = argv[i];
>           g_auto(GStrv) tokens = g_strsplit(opt, "=", 2);
>           if (g_strcmp0(tokens[0], "ips") == 0) {
> -            max_insn_per_second = g_ascii_strtoull(tokens[1], NULL, 10);
> +            char *endptr = NULL;
> +            max_insn_per_second = g_ascii_strtoull(tokens[1], &endptr, 10);
>               if (!max_insn_per_second && errno) {
>                   fprintf(stderr, "%s: couldn't parse %s (%s)\n",
>                           __func__, tokens[1], g_strerror(errno));
>                   return -1;
>               }
> +
> +            if (endptr && *endptr != 0) {
> +                g_autofree gchar *lower = g_utf8_strdown(endptr, -1);
> +                unsigned long scale = 0;
> +
> +                for (int j = 0; j < G_N_ELEMENTS(scales); j++) {
> +                    if (g_strcmp0(lower, scales[j].suffix) == 0) {
> +                        scale = scales[j].multipler;
> +                        break;
> +                    }
> +                }
> +
> +                if (scale) {
> +                    max_insn_per_second *= scale;
> +                } else {
> +                    fprintf(stderr, "bad suffix: %s\n", endptr);
> +                    return -1;
> +                }
> +            }
>           } else {
>               fprintf(stderr, "option parsing failed: %s\n", opt);
>               return -1;


