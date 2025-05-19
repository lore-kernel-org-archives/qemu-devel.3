Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10757C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH1sW-0003nX-TC; Mon, 19 May 2025 10:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH1sU-0003ix-TG
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:54:07 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH1sS-0001GG-P6
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:54:06 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43cfdc2c8c9so26182025e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747666443; x=1748271243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkg9nRry/L+60f6Mtg42AEWrifg6/RkUF65YcvPJ6fo=;
 b=C4mn+ENpGWEavXaDWogYFl8ER23Wc2TmXeO2cbxX5BWJyu6hBc/Sfob+i1J8ny7aQY
 HFcfFIjY5+pfQlSNPaC9CqEI8V7JJDH+1anQumCDmGagEKHHACjNn1mIhrYOcj5oNzql
 nIs8FeL00ffwQmtsP+a4aObJvFW85H9ThQFDXjljmad4FVrEnyG9amLw8KbmM6t96rl/
 YtNUQCNrTWm8KIrKfjsWnnxmv/EoqBzwmS131naX6KKc/MFOFWtsDcKEZOJEViOa+BLI
 yXy7MysOPaMYClHLbWGlgcBeebXt493rl7qIef7CydRejQ/BzRPlitCfzWVHNHI6PaCD
 pcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747666443; x=1748271243;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lkg9nRry/L+60f6Mtg42AEWrifg6/RkUF65YcvPJ6fo=;
 b=AaXlf4T4V247TCtU1Q45u3OjgyDBFKXlVCkXENNRKBEK4nbIFsCNwBlub6/e6RJnRj
 tX9sxQ4inR0KwqQvkifODGhHq31ONGwPPMl1zUT+yProaTeBd2QmaW6ZgztPu/OfeoeU
 iZSnRplJ/FAJ9Qd5I6vALEpe0N86gj0geBjOGZekdFb8mN9KL9jGwRXTfMBc5+6BIonm
 WxMVbYhsbHg8JFxEvoxXgrCK1rXnbLyBz3Wk+3xJ+zcdEjco90cuwXsioRo7IRi8TBtp
 DaHaYtG4ZbnRAkRiq+Ljvaf2pXd/nc2DcJEQrKkzrZSyvrocGktMaxqE0cCl4hRuETJS
 YB9w==
X-Gm-Message-State: AOJu0YykriW296+N8fFvVq9YKv0Flknw2RraTtyjl+i8XSyhcZl68qxT
 ieOWXa0iKt/0ZF0an8Rw1JZp7bfK1pKswpDmqgiXK3slka8xvxeOMX++EMMx9djVlJw=
X-Gm-Gg: ASbGncs7aM1uLfr1CwLwtDaGmO7vdczBTFYfkpo045YGtyYY053WQlKIibi96BA+GLU
 YguFLyyS6xeyhHKHfsZMAx2GE9ClzbNazrmfcthK5ODT54K8RUca5Mkl18CLxfDvTdwbLoATcfQ
 +YT/EwWhZhznzBF1RJen3l4uVIC6XksUql6kbHk7oR2EPuS01/ABZnlgFQET/VvyKPT5HN7yKbx
 714ZQNKGqZham+TXiGj1MVtjTzhbSMYtYyB8JnUHsors9lvVwR75OX+LefRgXE0EYXxD6DvuJUE
 VQv7ct21DZDUCpNmpTbiIiycYd3iKJ38pS+lIdL7vJa4cR2V4172
X-Google-Smtp-Source: AGHT+IFtFmCPs39mkfPtUoSjplqcPnMarbC/36VKz74FhFKylGS42WxyQvu4NfDbQz35UDa0kpFWLA==
X-Received: by 2002:a05:600c:3114:b0:442:d9f2:ded8 with SMTP id
 5b1f17b1804b1-442fd6444c4mr141474615e9.15.1747666442603; 
 Mon, 19 May 2025 07:54:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd5107f8sm139049185e9.16.2025.05.19.07.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 07:54:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 05BD25F87C;
 Mon, 19 May 2025 15:54:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, David Hildenbrand <david@redhat.com>,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org,  Mahmoud Mandour <ma.mandourr@gmail.com>,  Markus
 Armbruster <armbru@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Peter Xu <peterx@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  John Snow
 <jsnow@redhat.com>,  "Michael
 S. Tsirkin" <mst@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v2 05/14] contrib/plugins: add a scaling factor to the
 ips arg
In-Reply-To: <cabfe49b-38af-4ecc-a338-1fe175dd7226@daynix.com> (Akihiko
 Odaki's message of "Sat, 10 May 2025 13:42:38 +0900")
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-6-alex.bennee@linaro.org>
 <cabfe49b-38af-4ecc-a338-1fe175dd7226@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 19 May 2025 15:54:00 +0100
Message-ID: <8734d0slbr.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> On 2025/05/06 21:57, Alex Benn=C3=A9e wrote:
>> It's easy to get lost in zeros while setting the numbers of
>> instructions per second. Add a scaling suffix to make things simpler.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> v2
>>    - normalise the suffix before a full strcmp0
>>    - check endptr actually set
>>    - fix checkpatch
>> ---
>>   contrib/plugins/ips.c | 36 +++++++++++++++++++++++++++++++++++-
>>   1 file changed, 35 insertions(+), 1 deletion(-)
>> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>> index e5297dbb01..9b166a7d6c 100644
>> --- a/contrib/plugins/ips.c
>> +++ b/contrib/plugins/ips.c
>> @@ -20,6 +20,8 @@
>>     QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D
>> QEMU_PLUGIN_VERSION;
>>   +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>> +
>
> G_N_ELEMENTS() is already available.
>
>>   /* how many times do we update time per sec */
>>   #define NUM_TIME_UPDATE_PER_SEC 10
>>   #define NSEC_IN_ONE_SEC (1000 * 1000 * 1000)
>> @@ -129,6 +131,18 @@ static void plugin_exit(qemu_plugin_id_t id, void *=
udata)
>>       qemu_plugin_scoreboard_free(vcpus);
>>   }
>>   +typedef struct {
>> +    const char *suffix;
>> +    unsigned long multipler;
>
> I prefer to have an explicitly-sized type: uint32_t in this case. It
> also saves typing several characters as a bonus.

4Ghz would be a reasonable size and that would overflow a simple
uint32_t unless we start casting.

>
>> +} scale_entry;
>
> docs/devel/style.rst says
>> Structured type names are in CamelCase; harder to type but standing
>> out.
>
>> +
>> +/* a bit like units.h but not binary */
>> +static scale_entry scales[] =3D {
>> +    { "khz", 1000 },
>> +    { "mhz", 1000 * 1000 },
>> +    { "ghz", 1000 * 1000 * 1000 },
>
> Having "hz" as suffixes look a bit awkard. "1 giga instructions per
> second" sounds natural, but "1 gigahertz instructions per second"
> doesn't to me. Practically, it would be easier to just type "g"
> instead of "ghz".
>
> util/cutils.c has similar code though I guess a plugin cannot be
> linked to it.
>
>> +};
>> +
>>   QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
>>                                              const qemu_info_t *info, in=
t argc,
>>                                              char **argv)
>> @@ -137,12 +151,32 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_pl=
ugin_id_t id,
>>           char *opt =3D argv[i];
>>           g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
>>           if (g_strcmp0(tokens[0], "ips") =3D=3D 0) {
>> -            max_insn_per_second =3D g_ascii_strtoull(tokens[1], NULL, 1=
0);
>> +            char *endptr =3D NULL;
>> +            max_insn_per_second =3D g_ascii_strtoull(tokens[1], &endptr=
, 10);
>>               if (!max_insn_per_second && errno) {
>>                   fprintf(stderr, "%s: couldn't parse %s (%s)\n",
>>                           __func__, tokens[1], g_strerror(errno));
>>                   return -1;
>>               }
>> +
>> +            if (endptr && *endptr !=3D 0) {
>> +                g_autofree gchar *lower =3D g_utf8_strdown(endptr, -1);
>> +                unsigned long scale =3D 0;
>> +
>> +                for (int j =3D 0; j < ARRAY_SIZE(scales); j++) {
>> +                    if (g_strcmp0(lower, scales[j].suffix) =3D=3D 0) {
>> +                        scale =3D scales[j].multipler;
>> +                        break;
>> +                    }
>> +                }
>> +
>> +                if (scale) {
>> +                    max_insn_per_second *=3D scale;
>> +                } else {
>> +                    fprintf(stderr, "bad suffix: %s\n", endptr);
>> +                    return -1;
>> +                }
>> +            }
>>           } else {
>>               fprintf(stderr, "option parsing failed: %s\n", opt);
>>               return -1;

I've fixed the other cases.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

