Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 088CAC369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9RmJ-0005BU-98; Mon, 28 Apr 2025 12:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9RmE-00058W-EP
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:56:20 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9RmC-0000Dn-DG
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:56:18 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-af51596da56so4280239a12.0
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 09:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745859373; x=1746464173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T0KaVqr4Ya2Lhmm7Rv9ZGRlR9Ju5Y9CQh4xXn4kVikI=;
 b=bqIUqWr1or1W/iAJGxJyXzweWtMvv4Q8Ildrj2bhoEL+QQ5993gVNZ88pnjRdsHwko
 cvBq+RkCynDSZ5LFLye9mUs//6jmiL2UtOQQpzWxTwuaX8ITmn1WoILzIaL47jR9vFT8
 XaUdLrBBFXDJ8H5VflhfWX/XnjwDg1Qds+xqtc7qD2xgis6A5aOKX1c4sAOkF2HrE+jm
 88sU6/aWtIHfAAbdgxMvlCWGJx8983YsdGz53DGzXGxgQbtTwJpOd6C6nd+VsKYU/TrS
 KBudg12Ym6DoAcUn6jPAeifejrV3H31NAm6OtOL1eop9JD9dlg6Mw5Mg3w7UAWgZCvw8
 Fsjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745859373; x=1746464173;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T0KaVqr4Ya2Lhmm7Rv9ZGRlR9Ju5Y9CQh4xXn4kVikI=;
 b=sKn0D184jPv8AOZuecI0ru5irEAtwEWoNIZDNithkd2Z/9TTw0RwPkVIWLbT/SPwQr
 2RlSGLr5/inxaKyaFRVlhkrjyyN5LVjjba6jBq0rFCVTA4pVa80O66et+CO0zmGTfOyq
 rsh/3ibJc7qLhU3AGRP4g5r5bpOBb/SJdUNBMKR27MwAymGpJh0gWMB2t5/coXPmsuQq
 FA8ABOj9ZZ1Y+JCc/RG1ysH+a4Udb1AKLlQmO1Wz1tID/wFUZar30v36OXz/X/gxhk/D
 ioo6mkKvNiuQ/iaAHoeFj+9fWnP1wYmTYO04X1xtfGxxQOD2wNh3SjiGlstuGDSud/i9
 VVzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/9KXMJbbMpjOhqhSE0qVltFHp1PRC/A3SPNtKVmiTxdLOkJsGpHh47DhP5JZ//PXcBrw1TYPughnF@nongnu.org
X-Gm-Message-State: AOJu0YwtDaUk0jFM9h+0FLlZQUZkPuDYYgTaclKj1s8SgooHSF75XHz4
 zmcTMDpD3tdG3qkNrG68Gg5KxmUySuz2L00BffFVNFfNyBXYTr2+gVVK/LccZMM=
X-Gm-Gg: ASbGncuGN5Wz5tg+YRsz7xnwNALUfdyOPKcLm/zHqNGMgBSLjjt8M/XJ0Vl5MPcIE7x
 wcFmpqemwIdljT7FkVYsAIcxWckUBaiN/WwR9LODmsSBPzvzQtghBvBbne1VfrYlEYyUZvkQC0q
 6Fqr1AsQTqVDuObKvLTPbhsEvIHcWcgCqICb3Io+BsaUguQ80+sEnB1Iwzd4cRKbOr4b+Zc6bVj
 oMIiq1r5LFHThMybHL9htyXUPIsmXxr/VKrsS8aSq454Kn9PjZVjE9QsPFi7dY8FDyZ0GAIIEu6
 lG5x/iBbVHtqF12jGpH0kYmSgUKUywo3+kPSoTe6JZUaVf2NQsTfcg==
X-Google-Smtp-Source: AGHT+IFWDW/naykJRmwiHJrpKMrDij+sH4NpvuvkN/q4hd+zMKFtEvhLJ0JOLm668nkejInRHYYbDg==
X-Received: by 2002:a05:6a21:31c8:b0:1f5:520d:fb93 with SMTP id
 adf61e73a8af0-2093cb057e0mr374850637.24.1745859373476; 
 Mon, 28 Apr 2025 09:56:13 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25ac87d5sm8239698b3a.157.2025.04.28.09.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 09:56:13 -0700 (PDT)
Message-ID: <7f047917-75b5-46ff-9069-3da224931777@linaro.org>
Date: Mon, 28 Apr 2025 09:56:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] contrib/plugins: add a scaling factor to the ips arg
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428125918.449346-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

On 4/28/25 5:59 AM, Alex Bennée wrote:
> It's easy to get lost in zeros while setting the numbers of
> instructions per second. Add a scaling suffix to make things simpler.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   contrib/plugins/ips.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
> index e5297dbb01..1952e0866d 100644
> --- a/contrib/plugins/ips.c
> +++ b/contrib/plugins/ips.c
> @@ -20,6 +20,8 @@
>   
>   QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
>   
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +
>   /* how many times do we update time per sec */
>   #define NUM_TIME_UPDATE_PER_SEC 10
>   #define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
> @@ -129,6 +131,18 @@ static void plugin_exit(qemu_plugin_id_t id, void *udata)
>       qemu_plugin_scoreboard_free(vcpus);
>   }
>   
> +typedef struct {
> +    const char* suffix;
> +    unsigned long multipler;
> +} scale_entry;
> +
> +/* a bit like units.h but not binary */
> +static scale_entry scales[] = {
> +    { "khz", 1000 },
> +    { "mhz", 1000 * 1000 },
> +    { "ghz", 1000 * 1000 * 1000 },
> +};
> +
>   QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>                                              const qemu_info_t *info, int argc,
>                                              char **argv)
> @@ -137,12 +151,19 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
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
> +            for (int j = 0; j < ARRAY_SIZE(scales); j++) {
> +                if (g_str_has_suffix(endptr, scales[j].suffix)) {
> +                        max_insn_per_second *= scales[j].multipler;
> +                        break;
> +                }

Could we add an error in case the present suffix is not recognized, with 
the list of available ones?
As well, can lower the suffix string, so people are free to use any case.

> +            }
>           } else {
>               fprintf(stderr, "option parsing failed: %s\n", opt);
>               return -1;

With the remark above,

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


