Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CEF7CF34AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLiyV-0000CO-QW; Wed, 19 Nov 2025 09:16:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLixy-00008T-NK
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLixt-0000B2-Kz
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:15:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763561720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5eWGUM0fVyE7v5qJqotJvzLvaXQdGGcU3AWHD0AJzvc=;
 b=OQVQoQ3a+VwvsXDtAnikx+++CfInTU4jMSkgAaENyycYyuhXBf/aYHUC6kVv+ORbjNTMfF
 UhirR6uRWkzdbP0jBOBjij8V3Y3m+EnE/7HtRce+KCJoiWgbLe83G/nRwXJztncVIWZAK7
 bUh2DEW6jfxYmgkZjbYuvjFFwo1dtB0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-Qs0ftovWPqyWsBWbXdZ_eA-1; Wed, 19 Nov 2025 09:15:19 -0500
X-MC-Unique: Qs0ftovWPqyWsBWbXdZ_eA-1
X-Mimecast-MFC-AGG-ID: Qs0ftovWPqyWsBWbXdZ_eA_1763561717
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a60a23adso19893735e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 06:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763561717; x=1764166517; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5eWGUM0fVyE7v5qJqotJvzLvaXQdGGcU3AWHD0AJzvc=;
 b=mQSPmFuebFh2RaRY55P21Om5BqVlLGMQdqMoxhT+CGoBokJTYyaZ7voHpJd6BlUG6s
 OMOHt4YSiDFkji6SkYruhY/UH+BSOIaL9FKGoxMo+Q6BT7KeyU8Z7dm2+Ubvge82qcDU
 MZLQVgTzFFHPqxRLTSwCQaAZfYjswkWktk3jRLsUwqx4XUkfzIejwfapWb1jhAjYtLDl
 erptpd8nknwi3PMSqx/DrcC33y4sMlrf947cARfYqQ8eevKWzCG7rfZl46KPebqhGGxr
 p34Qaed4N9EtQ7HoxX/ojXuhn62UETmFvVSsb+LN6gerpNAvcsHd/ro/fq66CQPLpkJc
 iSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763561717; x=1764166517;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5eWGUM0fVyE7v5qJqotJvzLvaXQdGGcU3AWHD0AJzvc=;
 b=QJCatDt6tTISY15M3KFDTLc19wYPUgasQCs2RRZ0+ejnNlNsKrAYfEb129owJAi1qc
 JKD3C7ZACrKWylOPQ8R92dughIOziG/oUkeDyWewHy2cxjxyC9gvTFB/juL2xOvNxwhu
 jeBTKnhCiBu58DZuhdiN01FCPEzi1uh8/niNiAHK20SDGRt2QDRyKRihhXrwAoeQT5gQ
 ImdIrtv/CyHGa8u38foGo6nr8p5wgk96rMd5FFxCByy8kjQJnAgOokIiehoB/lmBNQXF
 okkfmQ9AyN1sZx+4IhbD2QWo5sIc8LZsCYVhz/hq23WiQ3VeNCAdHMpTRt7OUxXKEiTT
 1yTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTPsY28dxOKEAr1KP8KMlBE7DiMtxBagGzgum/IfW7eN4B8rWqFKR2K1qyORlxn8Uf/CF6CNf49szb@nongnu.org
X-Gm-Message-State: AOJu0Yz42ByGCWXl0VNk1vU4zt89bfjjXpPQ0OvVR8B4VVRD48mMV4TV
 GJpIjD9SJD2lIzljAyZ56zTsALZ8LAdh38g42K1Fw7+gsAED/z0sTJYq8TF8qu9BQKwJcTFJkkD
 1gsbVU2JsQBLpEUKxCYtTuxp0/tMIs6QP7bieyoKBzY3p5yjdtNNCC8z/
X-Gm-Gg: ASbGncvIiSsHyCyCOwIQv4ec88pCQBJe39TtyKFYG6atMZgaMqUVClEreZ+5aLupG9R
 H9em1Hr5ARnpKJnWYo9IXNnJ8nX4gF2XXS8b+aq+88slW+NeDM+PIRoRUx2A2TQbuwaXMuRbH4o
 od8u7mUC6Z3BJv89vDseMY//jr/HOpbLSSIiXzN3ON/vvjyd1I+GuCwJKV4zz8934lQhc2xWgS1
 J9I4Tzg5e6UecQuHCNNCgLyq6g3E6nfaUi/BSMUNfLErtC+8lj0wCmyiSpTdeWDw/EluzqmCoss
 VCh8Gm9qUldJJEJSNZjrgdNoUkvsJrcaY0ki3miR2l0VppC3mKTQ2Lvo1h7g9ug1Ur7xGZcRYUj
 MnUv8Tg/+w24Eh76fD2ZEOYPV+VBMO4T3AFE=
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4778fe4f06dmr197877355e9.3.1763561716855; 
 Wed, 19 Nov 2025 06:15:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFozC+JQ+nCHbzfKf+gFhkqO7khNj1zqnc0uRObs+4sT8si3b+ehixEM0eI18QGRgpXu8FgpQ==
X-Received: by 2002:a05:600c:46ca:b0:471:14af:c715 with SMTP id
 5b1f17b1804b1-4778fe4f06dmr197877005e9.3.1763561716430; 
 Wed, 19 Nov 2025 06:15:16 -0800 (PST)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de46cdsm40334765e9.8.2025.11.19.06.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 06:15:15 -0800 (PST)
Message-ID: <6111c59f-42c3-4c6f-8e75-209874d75363@redhat.com>
Date: Wed, 19 Nov 2025 15:15:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/22] tests: forcibly run 'make check-venv' for crash
 tests
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-18-jsnow@redhat.com> <aRtyTkIcuoNazF7L@redhat.com>
 <CABgObfZW5i4nYchoCTKeh7b3cxYSctpxFp=UV2a2V5t=zmDgNw@mail.gmail.com>
 <CAFn=p-a4_EX7FvobF2f8fH2=ZKemcZvobi0EKV4MpCiQM+TQ+g@mail.gmail.com>
 <CABgObfY6QPzH0xM+VOeP16Lsi+y9DEeim0tsx+yKXEW2skVPHQ@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CABgObfY6QPzH0xM+VOeP16Lsi+y9DEeim0tsx+yKXEW2skVPHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/11/2025 09.05, Paolo Bonzini wrote:
> 
> 
> Il mar 18 nov 2025, 22:50 John Snow <jsnow@redhat.com 
> <mailto:jsnow@redhat.com>> ha scritto:
> 
> 
> 
>     On Mon, Nov 17, 2025, 3:47 PM Paolo Bonzini <pbonzini@redhat.com
>     <mailto:pbonzini@redhat.com>> wrote:
> 
> 
> 
>         Il lun 17 nov 2025, 20:07 Daniel P. Berrangé <berrange@redhat.com
>         <mailto:berrange@redhat.com>> ha scritto:
> 
>             On Mon, Nov 17, 2025 at 01:51:25PM -0500, John Snow wrote:
>              > In order to convert the existing Makefile target from a manual
>              > invocation of mkvenv to one that uses the meson dependency
>             system, we
>              > need to not suppress ninja here.
>              >
>              > I'm not sure if this creates problems I am not aware of; but
>             invoking
>              > ninja here is no longer spurious but will become necessary.
> 
>             Yes, this will likely create problems. From the commit message that
>             introduced NINJA=":"...
> 
>               Avoid it with the same
>                  trick that we are using in buildtest-template.yml already
>             by disabling
>                  the up-to-date check via NINJA=":".
> 
> 
>         Move the check-venv call to buildtest-template.yml, right after
>         configure? It's cheap enough.
> 
>         Paolo
> 
> 
>     What's the root issue here? That there's enough of a time delay between
>     the actual configure and the test running that it re-runs configure?
> 
> 
> That the git repo is cloned again and is therefore newer than the artifacts. 
> That triggers a full rebuild.

Right. At least for the other "functional" and "check-system" jobs in our 
CI, this was a big issue, calling "make check-functional/qtest/iotest" there 
triggered a rebuild of all binaries, increasing our CI runtime significantly.

For the "crash test" jobs, it was mainly about avoiding to rerun the 
"configure" step for cosmetical reasons each time the job runs. The rebuild 
of the qemu binaries is triggered by "make check-iotests/qtests/function" in 
the other jobs, and not by "make check-venv" alone, so it's not as bad as in 
the other jobs here:
Without your patch, the jobs take about 16 minutes (crash-test-debian) and 
10 minutes (crash-test-fedora):

  https://gitlab.com/thuth/qemu/-/jobs/12138792667
  https://gitlab.com/thuth/qemu/-/jobs/12138792674

With your patch applied:

  https://gitlab.com/thuth/qemu/-/jobs/12139438583
  https://gitlab.com/thuth/qemu/-/jobs/12139438599

the jobs take approx. the same amount of time, so I think it's OK here to 
drop the NINJA=":" again.

But I think we should give Paolo's idea a try and move the "make check-venv" 
to buildtest-template.yml instead. In fact, that might even help to slightly 
decrease the total runtime of the jobs since all the other "check" jobs 
don't have to do this again (for example the check-functional jobs are 
running it, too, see: 
https://gitlab.com/qemu-project/qemu/-/jobs/12139584312#L1051).

  Thomas


