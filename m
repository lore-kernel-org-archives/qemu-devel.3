Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA19CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:15:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2Bv-0005cH-5K; Mon, 19 May 2025 11:14:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH2Bs-0005bF-7R
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:14:08 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uH2Bq-0003zD-9a
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:14:07 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-441d1ed82dbso45468405e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 08:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747667643; x=1748272443; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SQSMEfs1GmBhKRPTO4S91r8BGUP9wMS8GfmMgkyReZo=;
 b=yToVpvB+KL9v5lSt7vmoigZF3ynZsITpFOpIe8iYkJNG7aGI51aom+fIriB8+bYUpr
 CZXg3thzogfa5JiyYqsr1FXH+JNTshRLcNLE0yQa+RT+51Rinz8TTdKuC8qYF+Pi33js
 B0IvJDTOgET7TL3QboLB9hor4F7WxCxtcjA8hDMY+lyXj7PZOZy2gA4TF57COaMNn+/q
 WU3fFh5Bdjm4nOerMUVmCGBeV07USYxqd+FQ3rYgVRqlNh5hWAoG76caPa91XbyIMtC5
 5Gi21NIdd+L7n7L0UYMsbFCEp70HkN9brVfDl9VkBgSOV7xjjFZ8nGoV7G/CjikXPWPb
 6i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747667643; x=1748272443;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SQSMEfs1GmBhKRPTO4S91r8BGUP9wMS8GfmMgkyReZo=;
 b=h5VRAfhFlrfK/VJ2JC1C7kTaJ6zCRk5yjR4WO8HT1x1/8N8GL4PkTCDwmV4YavGL4o
 0+BW3bPsJ153fqsxjNv9BMTHQO0IKbs3+wkFWugF6pON1DSlzMVly60NKHf/3f6l8fKb
 iIOybs+FNBQpKTKuEVwsmBdaDTnuTN3TPlUEcLghsRKlltBHp4ShTQy0BUdaGaAu2g0m
 VK47bqzzM2JLeIyF7IqM4Z1Ihpvv5P4A9+A8hYQLRXKb7vW1k46E8sZN6f3yQlaMoA2k
 /aNWJozAzSbToMTEbUjgvHV1A2kwUOQ5E1FOGitcogtSWbZhbqVUnEJ8KhN6Pnro2Po7
 WWRA==
X-Gm-Message-State: AOJu0YwcpJALtj0WHctRWubKtPA98DLbxrCuhA90LfRqt7ysaPWIVuL5
 O6kUmlsVriNSQj9l85n4owbiH3QhzLaStuJVKFf7PExCICBlsRDL4GUr2x1Q+v2FPK8=
X-Gm-Gg: ASbGncvdfi5cVZieG2NTp3kboRZs+afM/mX4GCb/HJgOes/6ZtrChgBnlhtbCuDRf0Z
 Wc30Vd+h7G+0pdHoExRRN7kZBXUOdO6CDETm00u20gm+ziVlF0psnUHpyBYhLFYDWP/JgfOp8mJ
 exbuHZjpbK9fx3360W6e3sKrIfbrXvyugo6oJwT1+NGb7KbAonEpESCk0SeOWtm5kZVWrprqHqQ
 9R9961Il9v3XDYQauVM5pLIRBd7Dn4o3K9wt0FoNcwDhlS8zWnWI/CO3AnItYFGDxGSL1WnsrHa
 lO0FzJIL16EL3VjLUdMg7cZ0lLoAREvssxco2DWkvo+g69+XA/eP41zN6kGMij8=
X-Google-Smtp-Source: AGHT+IHbGfa2dL2KHk4uvOzJ9WGY0FfWpfev0KVTHk1FOeKJsuIb3TiUE5zcD7OIaqx7+V/u3RJLTA==
X-Received: by 2002:a05:600c:4e0e:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-442fd606b72mr144125705e9.3.1747667643556; 
 Mon, 19 May 2025 08:14:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f39e84acsm220509455e9.25.2025.05.19.08.14.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 May 2025 08:14:03 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 15E0E5F7EE;
 Mon, 19 May 2025 16:14:02 +0100 (BST)
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
Subject: Re: [PATCH v2 06/14] contrib/plugins: allow setting of instructions
 per quantum
In-Reply-To: <f0890b48-9b80-4ae7-892a-c45fd3dee089@daynix.com> (Akihiko
 Odaki's message of "Sat, 10 May 2025 13:45:28 +0900")
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-7-alex.bennee@linaro.org>
 <f0890b48-9b80-4ae7-892a-c45fd3dee089@daynix.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Mon, 19 May 2025 16:14:02 +0100
Message-ID: <87wmacr5tx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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
>> The default is we update time every 1/10th of a second or so. However
>> for some cases we might want to update time more frequently. Allow
>> this to be set via the command line through the ipq argument.
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>> v2
>>    - checkpatch fixes.
>> ---
>>   docs/about/emulation.rst |  4 ++++
>>   contrib/plugins/ips.c    | 10 +++++++++-
>>   2 files changed, 13 insertions(+), 1 deletion(-)
>> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
>> index a72591ee4d..456d01d5b0 100644
>> --- a/docs/about/emulation.rst
>> +++ b/docs/about/emulation.rst
>> @@ -811,6 +811,10 @@ This plugin can limit the number of Instructions Pe=
r Second that are executed::
>>     * - ips=3DN
>>       - Maximum number of instructions per cpu that can be executed in o=
ne second.
>>         The plugin will sleep when the given number of instructions is r=
eached.
>> +  * - ipq=3DN
>> +    - Instructions per quantum. How many instructions before we re-calc=
ulate time.
>> +      The lower the number the more accurate time will be, but the less=
 efficient the plugin.
>> +      Defaults to ips/10
>>     Other emulation features
>>   ------------------------
>> diff --git a/contrib/plugins/ips.c b/contrib/plugins/ips.c
>> index 9b166a7d6c..62ed8ddd08 100644
>> --- a/contrib/plugins/ips.c
>> +++ b/contrib/plugins/ips.c
>> @@ -147,6 +147,8 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,
>>                                              const qemu_info_t *info, in=
t argc,
>>                                              char **argv)
>>   {
>> +    bool ipq_set =3D false;
>> +
>>       for (int i =3D 0; i < argc; i++) {
>>           char *opt =3D argv[i];
>>           g_auto(GStrv) tokens =3D g_strsplit(opt, "=3D", 2);
>> @@ -177,6 +179,9 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plug=
in_id_t id,
>>                       return -1;
>>                   }
>>               }
>> +        } else if (g_strcmp0(tokens[0], "ipq") =3D=3D 0) {
>> +            max_insn_per_quantum =3D g_ascii_strtoull(tokens[1], NULL, =
10);
>
> It may be nice to have an error check performed for ips.

We do catch most errors bellow on max_insn_per_quantum =3D 0, but I can
check up here as well.

>
>> +            ipq_set =3D true;
>>           } else {
>>               fprintf(stderr, "option parsing failed: %s\n", opt);
>>               return -1;
>> @@ -184,7 +189,10 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plu=
gin_id_t id,
>>       }
>>         vcpus =3D qemu_plugin_scoreboard_new(sizeof(vCPUTime));
>> -    max_insn_per_quantum =3D max_insn_per_second / NUM_TIME_UPDATE_PER_=
SEC;
>> +
>> +    if (!ipq_set) {
>> +        max_insn_per_quantum =3D max_insn_per_second / NUM_TIME_UPDATE_=
PER_SEC;
>> +    }
>>         if (max_insn_per_quantum =3D=3D 0) {
>>           fprintf(stderr, "minimum of %d instructions per second needed\=
n",

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

