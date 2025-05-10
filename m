Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E1BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 04:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDc35-0003QH-3L; Sat, 10 May 2025 00:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDc2y-0003PV-JT
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:42:48 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDc2v-00071Q-Ao
 for qemu-devel@nongnu.org; Sat, 10 May 2025 00:42:47 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-309f3bf23b8so3487130a91.3
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 21:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746852164; x=1747456964;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pKj0+92XPB0tm2IzBJgADrWacxZv1TgpLy5sr0GANuY=;
 b=MdAoyb8UquCQvuEBgVMuZ1IHG5BkFbJq/PEvycWs08rAfUrsBueWz8/yXSRrs3yFzr
 GQuG8aX/y1VZuDlToAD/ocuvRS1ZxKI7fkWyQuX4v1/yQCEcQTrFsL082fsmAeKYaa8y
 FTnOOh/VHs0bJy5rXM9U02hJBIR6qk75syIzLDPV/7HLlyidUv81ZFvtiYv/M7netUzL
 R4kncpiVs7bmM53lyG/6X89CPZMLAq8gpOYi0zBZCnw2gdnlD3wPf9LvNCd3wPMCN+Nl
 fVo0O30g/8bqrRy4joJlfb1WzKIRgEzINl2myBi4lpkGlFFit03KyK1wpIqhmEkRgWQz
 dEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746852164; x=1747456964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pKj0+92XPB0tm2IzBJgADrWacxZv1TgpLy5sr0GANuY=;
 b=Mcn3ZNRy3dKtPOI1b0dqdLmCh+/QO3Q1vlbMmmcOAe90mSFpxyOFlVt/S5HYorhmwy
 V3/wVFnTvolEimtZqUY0COAI+DFl5jio9ASiPAh0dbaVpscMYcPTnyCfVd8dkImAHDlU
 nrQR0iiF/QYzIi+eAzB/u4YEW4184cwlHwfGPRqmSa0GDFDJhPkX28yx/D3Emssb/aCE
 FYXRe9/FVHwlRhtTzZ+Fdp0gPxwOWWhTViGJllIePoqqrkkcTHcA4WFvcRHkVxsRjPE6
 OY4FYbHvhL5rldjatHwiqKn19ysxtmHR+EokVTU729BK6bRCqdctu/tSmVOZo9msDt8H
 tB3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsAQQu9H0au2rPWhEYo+Jrl6fakyeDzZALLizWrbIlAe/DqwsWBACp8oDoxiMLbnlK6CX31r/ENxia@nongnu.org
X-Gm-Message-State: AOJu0Yx9SdWAyrOFqoKChGsZxAqLJ683M1xuYo5Zcgg1+8noaEidhxmN
 dmZxyizwSZi/+dchPnnQdsdJTDnhtAdkidFAzEyDcPk1qiHjKItKq56jItU4Ju0=
X-Gm-Gg: ASbGncuZh2y5JoMLL2udX0fMb4aQbCDABEQKOyrnIPXpfTGzLTh/keTm3tB0GT7w1eX
 WT/SZvxeI7SoGRlbxXUOaTd7guPjvOZu0yZAKnr0L819PyAmW+R9PKG7PKPjZrKwWqy0LH+juJc
 Gr2wZ1ojtxoQcVXnnHB0yoT75iw9bI1+SfuAr+gJSeKqEMLHzGnXCsHiVma4VmGGl7XBjTTGMkw
 rj8Rri4hWod0G5i/8nbqcnjWv7SrmnEEIBp3deK2golcq3KF3cGTCobsyLoqx+cBCHJhxX/pED6
 yAHJkF06R8pRQ1fevU/vttwUmyP3H1aOiWfmmA5P+Au0lDz+hpJX2JRCt1iV3w==
X-Google-Smtp-Source: AGHT+IHfBq0rzikQMG7X7NlwScAD2E0MqGgqTMZKI44qGpJNGbd+9I4OMMDi5xYz0ZOR2fgUcih/Pg==
X-Received: by 2002:a17:90b:55c4:b0:30a:dc08:d0fe with SMTP id
 98e67ed59e1d1-30c3d3e83c7mr10742320a91.16.1746852163791; 
 Fri, 09 May 2025 21:42:43 -0700 (PDT)
Received: from [10.100.116.185] ([157.82.128.1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad4d56976sm4957693a91.27.2025.05.09.21.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 21:42:43 -0700 (PDT)
Message-ID: <cabfe49b-38af-4ecc-a338-1fe175dd7226@daynix.com>
Date: Sat, 10 May 2025 13:42:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] contrib/plugins: add a scaling factor to the ips
 arg
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-6-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250506125715.232872-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/05/06 21:57, Alex Bennée wrote:
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
> ---
>   contrib/plugins/ips.c | 36 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
> index e5297dbb01..9b166a7d6c 100644
> --- a/contrib/plugins/ips.c
> +++ b/contrib/plugins/ips.c
> @@ -20,6 +20,8 @@
>   
>   QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>   
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +

G_N_ELEMENTS() is already available.

>   /* how many times do we update time per sec */
>   #define NUM_TIME_UPDATE_PER_SEC 10
>   #define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
> @@ -129,6 +131,18 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
>       qemu_plugin_scoreboard_free(vcpus);
>   }
>   
> +typedef struct {
> +    const char *suffix;
> +    unsigned long multipler;

I prefer to have an explicitly-sized type: uint32_t in this case. It 
also saves typing several characters as a bonus.

> +} scale_entry;

docs/devel/style.rst says
 > Structured type names are in CamelCase; harder to type but standing
 > out.

> +
> +/* a bit like units.h but not binary */
> +static scale_entry scales[] = {
> +    { "khz", 1000 },
> +    { "mhz", 1000 * 1000 },
> +    { "ghz", 1000 * 1000 * 1000 },

Having "hz" as suffixes look a bit awkard. "1 giga instructions per 
second" sounds natural, but "1 gigahertz instructions per second" 
doesn't to me. Practically, it would be easier to just type "g" instead 
of "ghz".

util/cutils.c has similar code though I guess a plugin cannot be linked 
to it.

> +};
> +
>   QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                              const qemu_info_t *info, int argc,
>                                              char **argv)
> @@ -137,12 +151,32 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
> +                for (int j = 0; j < ARRAY_SIZE(scales); j++) {
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


