Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F9D75BC8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 07:02:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE1CA-0007sW-2F; Thu, 21 Nov 2024 02:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tE1C7-0007sK-Fg
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 02:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tE1C5-0000Vf-Fo
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 02:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732172494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Mfu60397YPJKSwjjnGvcZWqH8InmycT6+Oe8AAR6nN8=;
 b=MP8/pFcMXeCEcPK6l04SYgBBE8Dosmb7u2IhgeU+VB3c0MtdSHcY9CJzLnPRjIcmYm7orU
 i7O/Cl3WmitLC+RM1jH0wg2hYxK1yeYw95rY7hX/s7FkSVzHQxG9ZE+qEQXygyTbUl+dvQ
 ihuWymlgqHxGdiJpO57zjl7+f13jtwY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-bwUFqaQiNl6Pd_ukXxhJIQ-1; Thu, 21 Nov 2024 02:01:30 -0500
X-MC-Unique: bwUFqaQiNl6Pd_ukXxhJIQ-1
X-Mimecast-MFC-AGG-ID: bwUFqaQiNl6Pd_ukXxhJIQ
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a99fc3e2285so32960766b.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 23:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732172489; x=1732777289;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mfu60397YPJKSwjjnGvcZWqH8InmycT6+Oe8AAR6nN8=;
 b=MSxZ9i88HJ3JWKTlpIzjDngjkG6+E6xBmnuF2JoHx46lhkYPJa22esn5I/i/Ksn+PK
 +PomAMUj56s17qv1/JgGKNpTeD/N5moL8hGWfFi8f8PK0UI9V7gb4pJ9IxlCsFNvZBNM
 rXgYwFszPIDbwqLUGRSwvSWEjHX15cTttY+9CIbuTDarYXGI7abRvvSA+MGfmnio+2gV
 EN9NW+YPDsEdfOM+Puto0W6TTblD0diGd9wjWfJzK2nH0uQmVy/fwCBZz4K6DwBX6U5U
 1fZO5/SvntGDefDxGUY93uVTdr6PLJI+dzEIe3bG7LbkC6NnaGDAGWMu54zdB2w5s8vg
 6Nxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1t0pXU4LrCx9CAcCUhwWMDs5SMWV0entzzeMOWACJwdVGiW6cOXSjq9fYbI7eGMAC/3OiyiWxtBjR@nongnu.org
X-Gm-Message-State: AOJu0Yyq9yX8+YYAuGKlNw/EpCXvZ4afKCsOurE+xZEMPAjaNNajzvmJ
 GKnS49RrL5YesAQ6WQ3MDzViSFVUQTKEeJ18t+Br6ZzKV4O5JisyFtLBBeG8XyJyyGvFs7s6DAv
 q59rcfw6eQJAjM9a4x0hgOSKOaJsNOdRs49vML+82yLKx0mY44Yh2
X-Received: by 2002:a17:907:d9e:b0:a9a:e6:a031 with SMTP id
 a640c23a62f3a-aa4dd752ff1mr541652866b.59.1732172488782; 
 Wed, 20 Nov 2024 23:01:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxtKkMb7o67mfzu4qir6CQBF8y4pMq6+zfYNRs9FaykZ3L5M5ItFLKk2gHgr+JUbA4SUJ2Hw==
X-Received: by 2002:a17:907:d9e:b0:a9a:e6:a031 with SMTP id
 a640c23a62f3a-aa4dd752ff1mr541646766b.59.1732172487996; 
 Wed, 20 Nov 2024 23:01:27 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-70.web.vodafone.de. [109.42.51.70])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa4f41818d0sm44327166b.80.2024.11.20.23.01.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 23:01:27 -0800 (PST)
Message-ID: <53a2bef1-c94b-48cb-b3e0-483c1b5b6ae7@redhat.com>
Date: Thu, 21 Nov 2024 08:01:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] tests/functional: add a QMP backdoor for debugging
 stalled tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
References: <20241119150519.1123365-1-berrange@redhat.com>
 <20241119150519.1123365-16-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241119150519.1123365-16-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 19/11/2024 16.05, Daniel P. Berrangé wrote:
> Support the QEMU_TEST_QMP_BACKDOOR=backdoor.sock env variable as a
> way to get a QMP backdoor for debugging a stalled QEMU test. Most
> typically this would be used if running the tests directly:
> 
>   $ QEMU_TEST_QMP_BACKDOOR=backdoor.sock \
>     QEMU_TEST_QEMU_BINARY=./build/qemu-system-arm \
>     PYTHONPATH=./python \
>     ./tests/functional/test_arm_tuxrun.py
> 
> And then, when the test stalls, in a second shell run:
> 
>   $ ./scripts/qmp/qmp-shell backdoor.sock
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/devel/testing/functional.rst      | 10 ++++++++++
>   tests/functional/qemu_test/testcase.py |  7 +++++++
>   2 files changed, 17 insertions(+)
> 
> diff --git a/docs/devel/testing/functional.rst b/docs/devel/testing/functional.rst
> index 6b5d0c5b98..b8ad7b0bf7 100644
> --- a/docs/devel/testing/functional.rst
> +++ b/docs/devel/testing/functional.rst
> @@ -176,6 +176,16 @@ primarily depend on the value of the ``qemu_bin`` class attribute.
>   If it is not explicitly set by the test code, its default value will
>   be the result the QEMU_TEST_QEMU_BINARY environment variable.
>   
> +Debugging hung QEMU
> +^^^^^^^^^^^^^^^^^^^
> +
> +When test cases go wrong it may be helpful to debug a stalled QEMU
> +process. While the QEMUMachine class owns the primary QMP monitor
> +socket, it is possible to request a second QMP monitor be created
> +by setting the ``QEMU_TEST_QMP_BACKDOOR`` env variable to refer
> +to a UNIX socket name. The ``qmp-shell`` command can then be
> +attached to the stalled QEMU to examine its live state.
> +
>   Attribute reference
>   -------------------
>   
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index e2a329c3e5..eb889a5bae 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -175,6 +175,13 @@ def _new_vm(self, name, *args):
>                            log_dir=self.logdir)
>           self.log.debug('QEMUMachine "%s" created', name)
>           self.log.debug('QEMUMachine "%s" temp_dir: %s', name, vm.temp_dir)
> +
> +        if "QEMU_TEST_QMP_BACKDOOR" in os.environ:
> +            path = os.environ["QEMU_TEST_QMP_BACKDOOR"]

Maybe slightly nicer to chech os.environ only once (and specify the 
environment variable name only once):

         path = os.environ.get('QEMU_TEST_QMP_BACKDOOR')
         if path:
             ...

?

  Thomas

> +            vm.add_args("-chardev",
> +                        f"socket,id=backdoor,path={path},server=on,wait=off",
> +                        "-mon", "chardev=backdoor,mode=control")
> +
>           if args:
>               vm.add_args(*args)
>           return vm


