Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B82D19519
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 20:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkTUE-0003gn-Uz; Mon, 26 Jan 2026 15:47:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkTUC-0003f9-Ku
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 15:47:00 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkTUA-0002NA-RW
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 15:47:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso42820435e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 12:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769460417; x=1770065217; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=szmoeSCZB2oGAr3DsY/ioF4jCUhLS4lG/vyf1OmUU1s=;
 b=UPF8T7/DrhpBhPlZgetTuJJzRkJirONv8we8Wm+cjxpcwPFJVhClntEm+8xdTiAXIp
 53RQUGWXvwYysjOp3/9xyBIynj6TFsY2Cq6KF8GVoIwHbnib1RGmFpTRh4ynsppaTAfA
 jaOOnNHXKOUgwA5PMjD5vk24YUmYCBqjrzkmZSMqRNBgShCgSmcJfUZBF5+tZI60hSBf
 HZsbTjWrpRp3aVbjRDIc4+tJkwaZvQfxz/pSQX+RBkZHYDPhSL/imvNhEHwlCf4RKxMO
 zF+CntaeggjAiIphj2uh1IcRbOpTg1GG1nPmf7y7jRCLLg8nE4Qo+I2Cp3w8GQoFATU/
 xSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769460417; x=1770065217;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=szmoeSCZB2oGAr3DsY/ioF4jCUhLS4lG/vyf1OmUU1s=;
 b=PZkncQ5rZjmbVUbtKDNSdOq/Mb8o+KHUzrn4mKBa5DX8pmyZIU2dRY7cDWpQ7g7psp
 5QDPw3yXp+tWD60b3lTYV44q3MH4hnY2/LG0GjDWuFsX401WQuD64j8gCDMF3jiv1i01
 VMix9ELOrgIV7olu2fIsH3AEJafAHVm1LRTBTRbyQXybUFd833aBc8f6liC1T+PAvXhP
 RWIukBWIBITq6QhDZoJo4EUgDm7200l66vWN6BwRFK6G8TTAQnlj6qPcM+cxX3WSVlzi
 kpP+uQha2NmF9NHeyKuEwCLwbDr8W0YNG6xx8dSJY0Uy20cRrAALcfq3U0ceFaJYbgwh
 R+Ng==
X-Gm-Message-State: AOJu0YxFdWR3G4FfYekwHLMss8xNDOxbgtJFuNlAv7740tKB4DU0WpAw
 6qGGL92KEmEcGGtBiBPkKUTq790l90Fqi8Iny+zkkwhF4FNzfJ1G5X91QHMMc2GPkuE=
X-Gm-Gg: AZuq6aJTzMFiSB0oDRAMg+SC+z22FONc63voHY1c8ZaLCc2ZyebYNWzwPczdu0e9W0e
 1gGXcJpUs9pqRJ0YA8mcKpjWOx2e5V9kTdT65BMUiS7xa1YYS65ILDXyGHopRDTdaxg58yTNjEZ
 Hgn1Yi0BVIm1Z2eSU6/j6gbqQTK5jp8LNTM6nlLAg+p1sa0WcegejnaBrtgcrXmArhPmGugyWEp
 yXzA7qepySrw4GKqnrgxVYBCTbbItA/MzjS4x3uMF71TntrTGKA8HFyzMxDe3uLm9r86+kNAnHc
 Tn0q9Ugde0DFLw2k2GVWTBW9FiWvzAE9IpIQrOJmiLhL8+m8EfC3Uc2A3gcZUfZnO07ii4NV9dW
 /MDAwxUPjcRXMawvmkP5TVXy+L+Egrxl1jKwVSyYRYKJS2JE34GX3qOspmbdPOarSoDNwdrt5sW
 Tzksz/hI5qGq83
X-Received: by 2002:a05:600c:a113:b0:479:1348:c63e with SMTP id
 5b1f17b1804b1-4805d96f4c5mr65277445e9.9.1769460416818; 
 Mon, 26 Jan 2026 12:46:56 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066bfb58esm12589965e9.8.2026.01.26.12.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 12:46:56 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 83F945F80B;
 Mon, 26 Jan 2026 20:46:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v3 2/5] plugins: add read-only property for registers
In-Reply-To: <871pjcdt5q.fsf@draig.linaro.org> ("Alex =?utf-8?Q?Benn=C3=A9?=
 =?utf-8?Q?e=22's?= message of "Mon, 26 Jan 2026 20:18:41 +0000")
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
 <8b36b6c1-83bd-462b-a346-f240dd17746d@epfl.ch>
 <871pjcdt5q.fsf@draig.linaro.org>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 26 Jan 2026 20:46:54 +0000
Message-ID: <87pl6wcda9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
>
>> Some registers should be marked as read-only from a plugin API
>> perspective, as writing to them via qemu_plugin_write_register has no
>> effect. This includes the program counter, and we expose this fact to
>> the plugins with this patch.
>>
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>  include/qemu/qemu-plugin.h |  2 ++
>>  plugins/api.c              | 17 +++++++++++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
>> index f976b62030..1f25fb2b40 100644
>> --- a/include/qemu/qemu-plugin.h
>> +++ b/include/qemu/qemu-plugin.h
>> @@ -942,11 +942,13 @@ struct qemu_plugin_register;
>>   *          writing value with qemu_plugin_write_register
>>   * @name: register name
>>   * @feature: optional feature descriptor, can be NULL
>> + * @is_readonly: true if the register cannot be written via qemu_plugin=
_write_register
>>   */
>>  typedef struct {
>>      struct qemu_plugin_register *handle;
>>      const char *name;
>>      const char *feature;
>> +    bool is_readonly;
>>  } qemu_plugin_reg_descriptor;
>>=20=20
>>  /**
>> diff --git a/plugins/api.c b/plugins/api.c
>> index fc19bdb40b..de8c32db50 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -403,6 +403,12 @@ bool qemu_plugin_bool_parse(const char *name, const=
 char *value, bool *ret)
>>   * ancillary data the plugin might find useful.
>>   */
>>=20=20
>> +static const char pc_str[] =3D "pc"; // generic name for program counter
>> +static const char eip_str[] =3D "eip"; // x86 specific name for program=
 counter
>> +static const char rip_str[] =3D "rip"; // x86_64 specific name for prog=
ram counter
>> +static const char pswa_str[] =3D "pswa"; // s390x specific name for pro=
gram counter
>> +static const char iaoq_str[] =3D "iaoq"; // HP/PA specific name for pro=
gram counter
>> +static const char rpc_str[] =3D "rpc"; // microblaze specific name for
>> program counter
>
> It's ugly but I can't think of anything better as you say in the commit m=
essage.
>
>>  static GArray *create_register_handles(GArray *gdbstub_regs)
>>  {
>>      GArray *find_data =3D g_array_new(true, true,
>> @@ -417,9 +423,20 @@ static GArray *create_register_handles(GArray *gdbs=
tub_regs)
>>              continue;
>>          }
>>=20=20
>> +        gint plugin_ro_bit =3D 0;
>>          /* Create a record for the plugin */
>>          desc.handle =3D GINT_TO_POINTER(grd->gdb_reg + 1);
>>          desc.name =3D g_intern_string(grd->name);
>
> Lets just set desc.is_readonly to false here.
>
>> +        if (!strcmp(desc.name, pc_str)
>> +            || !strcmp(desc.name, eip_str)
>> +            || !strcmp(desc.name, rip_str)
>> +            || !strcmp(desc.name, pswa_str)
>> +            || !strcmp(desc.name, iaoq_str)
>> +            || !strcmp(desc.name, rpc_str)
>> +           ) {
>> +            plugin_ro_bit =3D 1;
>> +        }
>> +        desc.is_readonly =3D plugin_ro_bit =3D=3D 1 ? true : false;
>
> And fold setting it to true into the if statement. I have a marginal
> preference for g_strcmp0(desc.name, eip_str) =3D=3D 0 style tests.

The option of course would be to skip the register all together. Do we
have code which will have multiple vaddr's for the same TB where using
the TB data wouldn't be sufficient?

>
>>          desc.feature =3D g_intern_string(grd->feature_name);
>>          g_array_append_val(find_data, desc);
>>      }
>
> Otherwise:
>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

