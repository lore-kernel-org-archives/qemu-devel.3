Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483A7CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 08:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEO9m-0003EM-7D; Thu, 30 Oct 2025 04:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEO9c-0003Dg-HX
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:37:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEO9T-0005xV-Ax
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 04:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761813416;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=s2bDkk012UoUz84GJrQ0NTHbj+oRUZZQ8Z5aewP4Jys=;
 b=MAEsyaG7a3Naf0+yOvs4/imgzZ8A5P8ltkcrkfX4Qf2d5cqcMavJ3AfI11PLuKAnc2Kzv/
 Lgr3cMLA13jFo4V0WePAzBnH8a+cs1439jHLAfpWzk1IPjAAb6UnAcMdt4rWIFzZwYBhJA
 0iSrcSJljg08QF2pOkuaHHDOFxHl91E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-1ay3xhuYNamTOW2HqGRu_g-1; Thu, 30 Oct 2025 04:36:53 -0400
X-MC-Unique: 1ay3xhuYNamTOW2HqGRu_g-1
X-Mimecast-MFC-AGG-ID: 1ay3xhuYNamTOW2HqGRu_g_1761813412
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-475c422fd70so7612455e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 01:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761813412; x=1762418212;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2bDkk012UoUz84GJrQ0NTHbj+oRUZZQ8Z5aewP4Jys=;
 b=E9NjB0ML5jN/rOS+vPYjz7wFUUjzlxcTsMEu5+1gnIvTFY4AAMuIbsjf4QkswI7YdE
 0mhACu+wGTGGXl6c5VhyIWhPMsk53shrJH6oRyJyy6ReAN7rGsFL8cwKkd7P+KfQ0Vgd
 llyx5GncjoyBq0I62Mx4hKm2+Sxe9MH0YPp3I384/uBjE94eD617tZMey9GIxJO3fDJp
 KJz07qjtPX7ByL+5JEl78NhhdOnVy7Ju8lkrpeDeq2UclJ72AkFozQ+mBFlGHgAQAFmu
 R5++aYSKx2vX4h5UHSTkXH3JBwE6EjMsfvg0JYbChuRjWu9SSIRLZmPAzmR+vmD5hib0
 7M8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyjwkwGTpI5pA//7+3fGWRix0xl3W9P6HJRoHGQJc1A3U3hj/StvvUGxP6XLwQ+bAx+XIEOpaCYNXt@nongnu.org
X-Gm-Message-State: AOJu0YxKbnrOa7un08JbiQnJKfbmgGwXPy0kHCuZqVYdeSBZ1mfcKh/9
 SDiSByl5idyCaALsYwwy7Xh9WxDRVTfDI0y6Gvs9GCSmj4oCQ9sVcCcFO5jnNC1hP1pkc/bBn6n
 kLxz0sxaY7xfHheyNpnPKpWwwjQKVhlUhbMlSAh7U8vFg99vxeU1mQS0H
X-Gm-Gg: ASbGncvGObYpM+tTqL4N7j8Wej19+8oaWd+/BbkgATzrbKCM+uWkN7r8ttRPnCAVlvi
 97gW/+A7txecahsbTWrMZ3hmurnoMtvqvJgywdTei6MI9GudxKB7MsP3yJoOS+WW3qeh3aVErAr
 y/tGW7Plfv5n0qhDDtw7mU8VRLnQFRz2bocZcOQnb1hwN+uX+0pXs8j9GQ1auyr9AIskqHesV1V
 7zs7a5TMNUnjIDck/Ht9M2cQZGKWBCKsIHaNo8rh+K2KVCatISkYfDrirHHVOVgJDSzlaafdkzN
 C9WH/4aOqBS0otTcVlxVbkCzbnhR/pYhm3oa0nD9s20KkqRIHncLcLjGDc7fx3n1cH75jB8=
X-Received: by 2002:a05:600c:608e:b0:46e:432f:32ab with SMTP id
 5b1f17b1804b1-4772684ed85mr18298095e9.33.1761813412345; 
 Thu, 30 Oct 2025 01:36:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+X2lOj4ntpsxc0a4BzJds5llmLeW2xcpkoTMnb7D1S4T8wBKJGTCANsO3AmfVpW5y1xfDeA==
X-Received: by 2002:a05:600c:608e:b0:46e:432f:32ab with SMTP id
 5b1f17b1804b1-4772684ed85mr18297785e9.33.1761813411754; 
 Thu, 30 Oct 2025 01:36:51 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477285d1e43sm31671775e9.0.2025.10.30.01.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:36:51 -0700 (PDT)
Message-ID: <8d65b802-f8b3-4124-ac66-1bb3e89a6013@redhat.com>
Date: Thu, 30 Oct 2025 09:36:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 05/10] python/mkvenv: rename 'testdeps' to 'functests'
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20251028220342.1407883-1-jsnow@redhat.com>
 <20251028220342.1407883-6-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251028220342.1407883-6-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 28/10/2025 23.03, John Snow wrote:
> pygdmi is only needed for functional tests and not tests in general; to
> prepare for more universally required test dependencies, rename this
> dependency group "functests" instead.
By the way, "check-venv" also seems to be still in use by 
tests/vm/Makefile.include ... not sure whether you want to mention it here 
somewhere, though.

  Thomas


