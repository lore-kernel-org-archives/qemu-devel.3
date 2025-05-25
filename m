Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F8EAC54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 15:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJDEb-0000iy-D5; Sun, 25 May 2025 11:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJDEZ-0000iC-6m
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:25:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJDEX-0007kg-FL
 for qemu-devel@nongnu.org; Sun, 25 May 2025 11:25:54 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a3758b122cso884353f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748186752; x=1748791552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8EsB4KKwhn+6yAx76oOErDAK4JdgouXBDYZw6xCXzeg=;
 b=BQppw81Tb6Id4IpFaL2/0pKjBMJbHK0mtfG/GoXZ8qf2You1NPOp6W8gxixzbMp/6f
 wT1oBIyKlUrrYjtvzozMm4ia7VbLp2b4MdlO5mIujPqPYTF7YgS39gW0U1wtWa3tB9KD
 JZMzK4/0Jh5NXKDR7Q5txfciH6GB0YKK/BodN6y4amR8VVemZ2SBeDTwKcSMVmQz64Fq
 nakVnzCd9oHwV7HXq930ZwcEHlnaqEmGfF+com9WFOQ8WfMug4cao5S8J11fW6cUkr8J
 oQiyMjy//4ivC90Ehan1lUvIWhrIg41yo61vjF42xM2OO6oYVXtlW672azWSTR1XjZXt
 zRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748186752; x=1748791552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8EsB4KKwhn+6yAx76oOErDAK4JdgouXBDYZw6xCXzeg=;
 b=EjJhNq4Bn3EpwmJ0N1jqqiuXvASdACzr/PWBaxbXqtNy1/jV7uqZ3NquX+/TgDAgJn
 ViYrWsvZYRrO/euCSycaEGp8lQ52y6L6GHpKWB4+u7NGorpBo4ylbLoUYXv7NYd2oiPa
 1VbFHTd+Ry4iqE4WnQBi+dQmsxNjGfSxif3SNB7ax7siUNii22RseGhFa3J/Qo/wBqHA
 2MbJFj/iFYEFxYS/GDm7GGIKvkG494uf/m7jy54uCoDPAJKzeXI6Jy3itHQdH4W5FFKc
 nKY5XWkAldZD6xGgXB7CVaB2SytpZiYH1+yP+Jn9udhZUeWOTDPI45t+a2d5nsvoGQ4A
 sYaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwKekjcF9exgyAclb6XtxJO6kNv9hLkl9WMg6D2SYJ5cXKXaBK8di9G726/IhTK0auXYRaFEOO88sh@nongnu.org
X-Gm-Message-State: AOJu0Yxm/4eeerWdT43z4+x94udZASfT7SFOn9AuhCRaQ3+LoWiuIAfO
 VUNb4gdngT5d9i2ocRTq9zMeZcmVNAnTbtt2pow5D2+EICAuBB5CZ+tLkn5J9S4YXB0=
X-Gm-Gg: ASbGncu0yi1u/c21gK5dPOX/USg1LOT7gfTWkoWwm/hFin2FQLutsjhxZwvt0uUOmDY
 ocUzPqxo6bgX3mANIPdXQpHn/zon4yp96xqCr+frrXg/pwwl2hp7QUfokssHRS2MPTYCct6b4B2
 YBiKTl6ysDMJmMjXfDLorQI6pnn2F0azbkuOlPlcjPtJGBaJA9SqstCYPRB+Htd1lbqFPEbsTUH
 WO/5j8469i1XDZVrF2eN1KVxNQGksj3NkU1wWCLniRYolTTw+IlD7ixroExcgK6Wxb7KKyOMKS6
 QRBXp71sAVspXV28vkpNvL+4tRsH4On/T4xih3q+BDBiBC3h0QZksAXisnpMRmWUdBLMUghWoSS
 uh67hz75RTprIbpUx0Ure3HrlOqc=
X-Google-Smtp-Source: AGHT+IFsOS88kQlU14Pm7ldF6CT5PMpUZVS7c5u/xFuefZKk9eMiOixR9+YAX4YqEkTGlcIuX516gg==
X-Received: by 2002:adf:f7d2:0:b0:3a4:cefe:4193 with SMTP id
 ffacd0b85a97d-3a4cefe4dbfmr3349399f8f.58.1748186751714; 
 Sun, 25 May 2025 08:25:51 -0700 (PDT)
Received: from [10.132.0.213] (17.red-95-127-33.staticip.rima-tde.net.
 [95.127.33.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cd0cf5c0sm4927892f8f.12.2025.05.25.08.25.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 08:25:51 -0700 (PDT)
Message-ID: <b916fe83-180b-48d6-815f-da556b8e42fd@linaro.org>
Date: Sun, 25 May 2025 17:25:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/20] gdbstub: Implement qGDBServerVersion packet
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, John Snow <jsnow@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>,
 Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-20-alex.bennee@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250521164250.135776-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 21/5/25 17:42, Alex Bennée wrote:
> From: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
> 
> This commit adds support for the `qGDBServerVersion` packet to the qemu
> gdbstub  which could be used by clients to detect the QEMU version
> (and, e.g., use a workaround for known bugs).
> 
> This packet is not documented/standarized by GDB but it was implemented
> by LLDB gdbstub [0] and is helpful for projects like Pwndbg [1].
> 
> This has been implemented by Patryk, who I included in Co-authored-by
> and who asked me to send the patch.
> 
> [0] https://lldb.llvm.org/resources/lldbgdbremote.html#qgdbserverversion
> [1] https://github.com/pwndbg/pwndbg/issues/2648
> 
> Co-authored-by: Patryk 'patryk4815' Sondej <patryk.sondej@gmail.com>
> Signed-off-by: Dominik 'Disconnect3d' Czarnota <dominik.b.czarnota@gmail.com>
> Message-Id: <20250403191340.53343-1-dominik.b.czarnota@gmail.com>
> [AJB: fix include, checkpatch linewrap]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   gdbstub/gdbstub.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 6023c80d25..def0b7e877 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -28,6 +28,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/module.h"
>   #include "qemu/error-report.h"
> +#include "qemu/target-info.h"
>   #include "trace.h"
>   #include "exec/gdbstub.h"
>   #include "gdbstub/commands.h"
> @@ -1597,6 +1598,18 @@ static void handle_query_threads(GArray *params, void *user_ctx)
>       gdbserver_state.query_cpu = gdb_next_attached_cpu(gdbserver_state.query_cpu);
>   }
>   
> +static void handle_query_gdb_server_version(GArray *params, void *user_ctx)
> +{
> +#if defined(CONFIG_USER_ONLY)
> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-%s;version:%s;",
> +                    target_name(), QEMU_VERSION);
> +#else
> +    g_string_printf(gdbserver_state.str_buf, "name:qemu-system-%s;version:%s;",
> +                    target_name(), QEMU_VERSION);
> +#endif

g_string_printf() isn't really justified, we usually call
g_string_append().

> +    gdb_put_strbuf();
> +}


