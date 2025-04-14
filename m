Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D947C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 07:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Ecj-00015S-No; Mon, 14 Apr 2025 03:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4Ech-00014e-Jt
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 03:52:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u4Ece-0008HS-As
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 03:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744617170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z2RYptpOAjGn32fyOu/qdKfQEPbVuYivyPUTT6mHBio=;
 b=eCJ0qI66nEyG9wrkEEpD3iORVtsvBAv5vSTEFl6qvmkO4L9KUnGgqVbXICnCzzxFswYM8z
 8k9Jboj6lMOF27dWODnU35bOHyoDjCE6He9tSPqF6owvkOYP5+ZsxjLv2HPo5vDdXqreAo
 PJEvHUNaixJ5mOlVa4UkvEt2ns0Tlco=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-o7m6n4aoMvWeV8bDhj5BSw-1; Mon, 14 Apr 2025 03:52:48 -0400
X-MC-Unique: o7m6n4aoMvWeV8bDhj5BSw-1
X-Mimecast-MFC-AGG-ID: o7m6n4aoMvWeV8bDhj5BSw_1744617167
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf446681cso26233095e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 00:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744617167; x=1745221967;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z2RYptpOAjGn32fyOu/qdKfQEPbVuYivyPUTT6mHBio=;
 b=tx8nDVqJc/TxaYPT7DdzqKBYaVy6aicPy+R5Rzzx3Vouzth+aTFo8rdrUnBGutS8sz
 kIZmKuz4beXNhzwKqELKVxqwxEGYPaOJxwDRj14TjlyOrLBIv2DpNce9if7kdoXyogcn
 OvormHGgwcRJF7YeFFQJLZl3/8bnAvWOZh2CT5aDjtJRzOLVi9Ms9a8/2K2j9VV4+eJG
 N1RhSVGYd0ypINOAadWUekJMOGcBd0hr3B0SpTxRINUQJlaineHaMFHasHdTbk1NUmU5
 tj3pKwQEhPH2uK3m2InABcTuKiMkVvQrYzU2QXBdenrE1UVgVTBfTM1GXSUVY5FEKfSB
 Sdsg==
X-Gm-Message-State: AOJu0Ywn3nlDm8cLuiX15v+FXX2Qo1G5DQR7QnI0o/sCmm5RXGA35c7U
 kliKw/L1grWydFHmgExQL5h3lWxE3b2e26lT2I60aik0tR5T27dnEF/4WG4XQgXisDCdXMEC+VT
 uuH54+Xs90q3+xwlYi4f2xqOGbzDOVRfYCxA+9ZWfZMTm+bNfInhv
X-Gm-Gg: ASbGncv6gOHoViAH4Vvry1z2kFM8hXzNJMzL7sk2FlQ3272dStG35ihUTirJBb9r8lW
 fDcj1YjsD4gFny7tD9p+oeVKLOQK0sx9+12LBNNl+efmd48+DfaIYXF85kvSBkBcMKGUT93Y9vB
 pssCwyFKpAJSe8sLdCp8Sb9t2Y6AvcrM7HnEtLTkBcO82Dp07XzVUnFoIbkQ2zbytLPWM+OVjVv
 U/3bGk+muWKTrsbJiQaxRnSfSN8VvAPGxKytocu7Ys6R9ay9yb/4PQ0+SeezR6zh7L7WG9g83e5
 Pns9yNAkGo3VNl0AlIVtvteiZoUz0RvIM3w1
X-Received: by 2002:a05:600c:4fc1:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-43f3a9b015amr78473675e9.29.1744617167165; 
 Mon, 14 Apr 2025 00:52:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5p3YMReihXNbmbnVDiLgL7t4mzxEKJh54YsBcVTeuHo9PamoTV3NgUUTo3c3mZnHjtIGLnA==
X-Received: by 2002:a05:600c:4fc1:b0:43c:fd72:f028 with SMTP id
 5b1f17b1804b1-43f3a9b015amr78473455e9.29.1744617166759; 
 Mon, 14 Apr 2025 00:52:46 -0700 (PDT)
Received: from [10.33.192.219] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f20625eeesm170359795e9.11.2025.04.14.00.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 00:52:46 -0700 (PDT)
Message-ID: <5f538130-184c-4105-ba3c-c27631c8c13d@redhat.com>
Date: Mon, 14 Apr 2025 09:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/15] gitlab-ci: Update QEMU_JOB_AVOCADO and
 QEMU_CI_AVOCADO_TESTING
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20250325200026.344006-1-thuth@redhat.com>
 <20250325200026.344006-15-thuth@redhat.com> <Z-PN0tip7DDurAVU@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z-PN0tip7DDurAVU@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 26/03/2025 10.50, Daniel P. Berrangé wrote:
> On Tue, Mar 25, 2025 at 09:00:22PM +0100, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> Since we don't run the Avocado jobs in the CI anymore, rename
>> these variables to QEMU_JOB_FUNCTIONAL and QEMU_CI_FUNCTIONAL_TESTING.
...
>> -QEMU_CI_AVOCADO_TESTING
>> -~~~~~~~~~~~~~~~~~~~~~~~
>> -By default, tests using the Avocado framework are not run automatically in
>> -the pipelines (because multiple artifacts have to be downloaded, and if
>> -these artifacts are not already cached, downloading them make the jobs
>> -reach the timeout limit). Set this variable to have the tests using the
>> -Avocado framework run automatically.
>> +QEMU_CI_FUNCTIONAL_TESTING
> 
> Both old and new terms are quite verbose, how about
> dropping '_TESTING' suffix ?

Sure, I'll drop it in v2!

> With, or without that rename though:
> 
>    Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks!

  Thomas


