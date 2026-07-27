Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DF9C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woENH-00027w-PI; Mon, 27 Jul 2026 01:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woEN8-00027M-7b
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:59:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1woEN6-0005PV-4l
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 01:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785131966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Puq2d6F6vDpGkjWbMZGRG2/oTh+XUfcOh4VyEMMetlY=;
 b=C3GJhdNOeh/9XAHPrAX9mJPZv/E8Ho5BUqOsX/du7k9+cf3hViTh/kPkhdc2BT9Ljzo/F5
 lDCUC99BH3LWG19Vd+lGFnHgEJ5k1eTWRI4yZEnEsTrcuJ9JKqFQ0O5iMcbKva4FailBnS
 R0i9ZIo7qWc8ezDz6heQcIKpB4AD3so=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-hOGMLimIPGuV7zidLV5P3Q-1; Mon, 27 Jul 2026 01:59:24 -0400
X-MC-Unique: hOGMLimIPGuV7zidLV5P3Q-1
X-Mimecast-MFC-AGG-ID: hOGMLimIPGuV7zidLV5P3Q_1785131963
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-496c06ba017so1703855e9.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 22:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785131963; x=1785736763; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Puq2d6F6vDpGkjWbMZGRG2/oTh+XUfcOh4VyEMMetlY=;
 b=g9Kdx11N00vh8e/F11fCefh9ki9NVVBSvDS+DiIFH6QqOJ/NwWgHvjWXsfWCU5ddy2
 adNPTbM9QdVrGDytC/lHrryZ9M6vwyPGA57aNUGDyigr2lqvIz35CvbHMuYE6fGj8jbw
 4f7KB6hV5QJugkOR5mgBkJ775t6/gKWSkCgFWInH6nEfb64m/r4Hfi0eo2qZFATUoOP7
 ugaqVStkwmKBRNG//GupI3KPSKtFItE3X84JSK9MUBe/CHPB3cuTo9t9XDdZUHvj5aiN
 cRQGvvsWII4jKB0HB49zokK6myTy7eApa09+GkuJr493ouwi0cFGVJ7NkBzfSKBQaHS2
 e5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785131963; x=1785736763;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Puq2d6F6vDpGkjWbMZGRG2/oTh+XUfcOh4VyEMMetlY=;
 b=dD8znmCrI6cewiy60TLAo9DIODJGzwz/xoucNcWG7zLPxsnSUcRUkRECyfqmP9eyIC
 tnCS5kGmLGWxvB+amlFGQqalpsjTyiExMkseTocrTmZorIwizcQTqTsIt3b/YnL+nB/c
 lBwB68RB08PY9rU6So30kQ2vR79yGa6823rjA7hEKvNaGyc4uZcUgYFMli6dNWnxNZJl
 oXd2POaSE2q4+ttlyawjfr0YkjnvlFXFxFC3DPcpEuBo9mmGP9gLaIa+6CLa/vh0O711
 AgEZ73rGpmOgqIPaBiWo8gtEFAfJEE4Ybu9c0azomntjvUo8NG115TM8oV1ykxbsn5BE
 xtZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqKLAbOtdjEli/bKizRHN3VYz89quxaflh1H9duIhPXuzs3Wx5ZKaEr+KiUxH59kmJ9iE6/9fHxFi/5@nongnu.org
X-Gm-Message-State: AOJu0YxLYdUh4+E5O13L2HSRLMGpfRWxdm01ACdZpuwq9zN00TsqzfeH
 cCrPtC/o8rF1HIqu+mRohQanHra+RYvK+nv17lxyfrhreAMf9uJZ8v93d0z1jpIF6k/c20Qjmk2
 D521/1+5Wuz2SWhsMFUt6H1ErWB7Qx6qlFZ8xydNqOJhUOMbiNrLhNMUC
X-Gm-Gg: AR+sD11tTD59K9RWaUGSzoPbVwhhzbB0D35B7UtMo+10tV3EI70xxeg2tg+GfV5qlUP
 yN29UyPRusq7E/b0vFryPdz6HqestMxuT3wSqAPIF/kEZ3oPWMnV69X3QXPngWmYvKn3YKE11r5
 IybhDBmA19WU1bLw3bps8YIg55lLRa7H3UIzBNb5aidnfCQISaVt6BhVyen+uVPQzQrWfeR1roq
 f6aqZhh7IdcSvu/rrNyfR0S4Dsizf+lYahMtZ5CdZ9aBJq1a05qneQ9DLy4eoMnKRF/d6YMetGz
 Rc4lf/aAqkIQ0uqZSGyXH5xR+sLbD7NESYIs45qSEkrZbDhJ/4wgNejGn4RuI0OS3vR64Mv3fw=
 =
X-Received: by 2002:a05:600c:41c5:b0:495:4f89:8117 with SMTP id
 5b1f17b1804b1-496885cba22mr70085945e9.1.1785131963117; 
 Sun, 26 Jul 2026 22:59:23 -0700 (PDT)
X-Received: by 2002:a05:600c:41c5:b0:495:4f89:8117 with SMTP id
 5b1f17b1804b1-496885cba22mr70085755e9.1.1785131962802; 
 Sun, 26 Jul 2026 22:59:22 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.113.188])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f96b9abc0sm25392727f8f.32.2026.07.26.22.59.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 22:59:22 -0700 (PDT)
Message-ID: <229c9cff-03f3-4404-a85a-dba831722e21@redhat.com>
Date: Mon, 27 Jul 2026 07:59:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/ppc: skip remote interrupts test if
 -net user not built
To: Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
 <20260725174600.17683-1-shivangu@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260725174600.17683-1-shivangu@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 25/07/2026 19.46, Shivang Upadhyay wrote:
> While running remote interrupts test, without libslirp-devel installed,
> facing the following panic logs.
> 
>    File
>      ...
>      raise VMLaunchFailure(
>      ...<3 lines>...
>      ) from exc
>      ...
>          Output: qemu-system-ppc64: -netdev user,id=net0: network backend
> 'user' is not compiled into this binary
> 
> Adding netdev user requirement for this test.
> 
> Suggested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> ---
>   tests/functional/ppc64/test_powernv.py | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tests/functional/ppc64/test_powernv.py b/tests/functional/ppc64/test_powernv.py
> index bac2017e18..9a95b6011d 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -91,6 +91,7 @@ def test_linux_smt_boot(self):
>       def test_linux_remote_interrupts(self):
>           self.require_accelerator("tcg")
>           self.set_machine('powernv')
> +        self.require_netdev('user')
>   
>           # Have below setup in this test:
>           # 1. e1000e attached to pcie.6, which is from 7th PHB, belonging to 2nd

Fixes: 63f5ba80921 ("tests/functional: Add remote interrupts test ...")

Reviewed-by: Thomas Huth <thuth@redhat.com>


