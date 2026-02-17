Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303E2E68156
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHiI-0001QX-1F; Tue, 17 Feb 2026 04:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsHiF-0001PY-Uh
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:49:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsHiD-0004rf-Af
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771321777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KdfpcWEH7lB1i89f80n2hUQMflzH6rTJ0YsqBuUuC9I=;
 b=bWPAIC0IIJmhO978cI7TjezWZqtnTozf91+cincFXvIoYLqD+qQmgaSGsrQbR9C3kjOKrO
 6GqV5eZ9O31gzc5j2TzTSYdnV9z/wKyG5eZY/h3O7xNqcA0wynL3k2JGGFNIEsCUWIErlw
 qij0od7ECw4HjHKD1q5doK2syPynVXU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-3YzudVhGPwSRbjA4bZ2zzQ-1; Tue, 17 Feb 2026 04:49:36 -0500
X-MC-Unique: 3YzudVhGPwSRbjA4bZ2zzQ-1
X-Mimecast-MFC-AGG-ID: 3YzudVhGPwSRbjA4bZ2zzQ_1771321775
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso26698295e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771321775; x=1771926575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KdfpcWEH7lB1i89f80n2hUQMflzH6rTJ0YsqBuUuC9I=;
 b=Ps9K38w+dYwR85I6556rjsXZ/lWU/iw3NXT6ZtUKFnu4ThJnmOtcW3l8Ke3gJEorjf
 v2wrcingjX+1pF8ZQVOZdiehdiChPh2C75ghPXiakI81QQdrOqZ2F+zpaGVI+8DQinyY
 7LP25GQNbLxd0yxZBEKt/iA6ZgkVn9vFPF4pgGgN15HIrZ7tCOv0Gz1FZNN8qzVxGNUM
 AgVe04nkhztf+mc1AVYvfkPRcuuIe5xOvZK1PZdgcaKZEj6bf5wiP5Um58DrUKYb04bp
 4Ei4UnbTBpcWgQ/7x09VxOl4i+tUpGs5Jz97um7/igrGghuhXRH6NNvr25F7Ab2g6l3K
 MDyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771321775; x=1771926575;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KdfpcWEH7lB1i89f80n2hUQMflzH6rTJ0YsqBuUuC9I=;
 b=eYT/PCQ/md7yA+T7ckSuQDtoR2UUnyGNxa5epvwJRM0fBXP9/No2cCeR91oMF0y0aE
 VK1Nn53ULS5LP4iZrve2zuUWxWtlWNRPRI0gS/FnOmPsdj0NNTp+muWVvo9smVi+8itx
 rdD2/GTQCFDO/+bC/VcgPb31dmiZ4RT2F2soKfewLoAFIJHTUMrIH6FfF0AXJQD5hcPd
 giWcLs7Jmwmb1nOZZr52Jp49ecsOd1GeO+a91cXj8a6QQrxoIwalhmkihwEbsqWMiQ8i
 xiiRtlVR+fEaR2FWdps964D7Oj5ApX4VQkREizdEUxCZ13c0gnPbCdIFqD94lou+utXL
 JmtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl1aydjsZig2xlA3TR0wUZsS02Qut1MM5+slc+dd+gwa/XI2U58TA7l+Tq7BThXNsTPtAAy/J3IzVD@nongnu.org
X-Gm-Message-State: AOJu0YzNyJNBCPbKOLlcR8dJ6SXr4Q2IPY6g4aXn9YvDGxcxVtYPWj7t
 +u5CIgTUhDNCneX0XaqUDfeOEM73jUyBqYwKTJpqG8e4VTYkWufnGUNvvA6Dbq+D4Pr4wKA2io2
 exB13BnWYQ5WCS/8FEi7HXBaBV0+oTgRwIAfyTjGqkn6AZCNv5UsDyeqQ
X-Gm-Gg: AZuq6aJ3eipdY1GpXq/K8aoaN1uRrtCx9vfWmWpxS1NZi9GkA3q99Hnw+DopdYROiOv
 XZ9bK0y56woCWQxoWjsunrQxqwprpljW9YGKK7kubf5HM5JmVYUsqo2dSoUCFvVXp6slPdbOyze
 Ng86epcMGBDoYB7yfb/j4bONWq0IzvAV5dLmFUHIy6LM54v1ApCuZsqlCS8NQak1l/Z8OD0HZHB
 8zkvyeG/5n9WVtWwAaZs9WElFDt8rTIaPjW+XRpCth8a0RfLq7m70v6kgljIqpUpWRvW5C7wbW6
 qVL39OY+2AU8YuqpmluAu4Odo6L1fe7JrUxm6miR52PAhbpCJuS2ksUQiw5STDsK9PdO/EdIOmG
 GbgEvbJyctGvBGNY6kp+AE9XIUsnlBUrYxPup6XzD0sjFsMQ2jMapWUe6YiUXHVsYqCMitPLIp0
 P5QxasQEdRaY2exh3RDOAPRxap464=
X-Received: by 2002:a05:600c:8486:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-48373a1c41emr196314845e9.11.1771321774905; 
 Tue, 17 Feb 2026 01:49:34 -0800 (PST)
X-Received: by 2002:a05:600c:8486:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-48373a1c41emr196314585e9.11.1771321774452; 
 Tue, 17 Feb 2026 01:49:34 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483719b8e71sm312572205e9.2.2026.02.17.01.49.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 01:49:33 -0800 (PST)
Message-ID: <146c95fd-00f2-4b51-bda5-249dd768a719@redhat.com>
Date: Tue, 17 Feb 2026 10:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] audio: do not build audio-related sources with
 --disable-audio
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-8-heifetz@yandex-team.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260217052740.114117-8-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/17/26 06:27, Sergei Heifetz wrote:
> When QEMU is configured with `--disable-audio`, do not build any
> audio-related sources.
> 
> - audio/meson.build and replay/meson.build:
>    Exclude audio-related sources when audio is disabled.
> 
> - audio/audio-stub.c:
>    Provide a minimal set of straightforward stubs.
> 
> - replay/replay-audio-stub.c:
>    Move the existing stubs from replay/stubs-system.c into a separate
>    file.
> 
> - qapi/audio.json:
>    Remove the QMP `query-audiodevs` command.
> 
> - audio/audio-hmp-cmds-stub.c:
>    Provide meaningful messages for audio-related HMP commands:
>    stopcapture, wavcapture, info capture.
> 
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   audio/audio-hmp-cmds-stub.c | 28 ++++++++++++++++++++++++++++

Can you remove the commands instead?

> +AudioBackend *audio_be_by_name(const char *name, Error **errp)
> +{
> +  error_setg(
> +      errp,
> +      "trying to find audiodev '%s' by name with audio component disabled",

This can be simplified to just  'audio disabled' or something like that.

> +      name);
> +  return NULL;
> +}
> +
> +const char *audio_be_get_id(AudioBackend *be) { return ""; }

Can you instead compile out qdev_prop_audiodev?

> +bool audio_be_set_dbus_server(AudioBackend *be,
> +                              GDBusObjectManagerServer *server, bool p2p,
> +                              Error **errp)
> +{
> +  error_setg(errp, "trying to set dbus server with audio component disabled");

Since this requires an AudioBackend, which you cannot get with audio 
disabled, it can be simply abort().

> +if audio_enabled
> +  system_ss.add(when: 'CONFIG_TCG',
> +  if_true: files('replay-audio.c'),
> +  if_false: files('replay-audio-stub.c'))
> +else
> +  system_ss.add(files('replay-audio-stub.c'))
> +endif

I think this can be simply

   system_ss.add(when: ['CONFIG_TCG', 'CONFIG_AUDIO'],
      if_true: files('replay-audio.c'),
      if_false: files('replay-audio-stub.c'))

but I may be incorrect.

Paolo


