Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AD36EA3F31
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 09:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpkIT-0000lQ-1V; Tue, 10 Feb 2026 04:44:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpkIR-0000iR-9y
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:44:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vpkIP-00061K-Lv
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 04:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770716676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbt1uKwrNrk0Y67+PqfGVqQealWEd1+aDrEKGEBd/OA=;
 b=CN+94I6MBysaADQcxPBigZbhTsoHkj0m6M6L94A8O16JC0rYhQm3/Jy14Ydyjym4WX33no
 ISwNzcJjiRa1mArPQJ237w4Tgo/xhyqFIPGFz+dthu1G0Z+WBJvvOUdDHEljllGXm25tb7
 uZPvgiR7CHkS8/M4sahG1Ye1JOTeOJo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-yJ3VG6yqPrOI90jm3KJpOg-1; Tue, 10 Feb 2026 04:44:35 -0500
X-MC-Unique: yJ3VG6yqPrOI90jm3KJpOg-1
X-Mimecast-MFC-AGG-ID: yJ3VG6yqPrOI90jm3KJpOg_1770716674
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47ee1fe7b24so63208335e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 01:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770716674; x=1771321474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wbt1uKwrNrk0Y67+PqfGVqQealWEd1+aDrEKGEBd/OA=;
 b=J3EiwYTywV3pujRaiUfLZJ4h72hWWRxTtw23mp5FcTCk8jKfb3Oe4DRAgzzUZCr12x
 DG2AtGHjNo1dO5Ub9mLeG+MtsZOSl8Lc1WHTZOvdinkEf355iG/U7c39AIwOU/LMTFaf
 rvcpelHhr3nK6K+Wo3/wqp87valtOUCKkI6I6WV39fLBKWU9YdRl01Wkls+ZCnBcrg6w
 4VOHEogHSdjeg8yfHp59hobiADUpEwUqhjwU9DJBe2Wy453+BIYjzCMyp+GRb2NO9jJX
 5UPHLfOpX6vtFSK/Dq1A6DlJUGLw0DVD586D5u48ex8+IAnmrugFNJBHXUN/3XRDz8TQ
 lw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770716674; x=1771321474;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbt1uKwrNrk0Y67+PqfGVqQealWEd1+aDrEKGEBd/OA=;
 b=d4qW6vEcJ/C5B0GhW8hpRu1CIPeOA++YFBxD/DnCsFpNS/cL0PQEeMxgXODtvRdq1m
 1QkWIED+juKDJByntHgfrhT5M4WctJ2KyvoMQ7z/XLexq/x4lj2egM1AGL/bWTOgA+45
 QEZlnB4ZQ17hzkcZiwjIUsNDCJoTVNmnCXD27LF1CWUtZ/1sI4I7q48Gu8cvFQfcnf7O
 Izqdw0is+Tr5MQeVoGWLZt98AcRo7msWS04Z/x9256IBTGTJ/X3ECT4r5O1R303HZ4tE
 eHvwbqZSy+2fEGQRSQXiiqltU9YMjnFbRihl20s9nfHgIlB1jsAHDGY0zA1rQCsTJnm3
 pp3w==
X-Gm-Message-State: AOJu0YyxE1sr5eJrzOAMdyyqhm11VJeNCh5INcSvLMxeZWtSjUDBnyY/
 sTQKjaW2fPnOcmevc8zOPDZJwezTt78tCSC1GHk8A8XyU+RDXko2eMcMx+8lmn+MTSYCLQUWl6k
 1V4FNXwN89tC4ZYK8rALhcTwr+D1GTbVMjOehrZGbVp2rZdQOmnaFJ3RD
X-Gm-Gg: AZuq6aK0ZVkUGDJEYX/I6OucLAQGsloiSZ+HxCpT83wDygfov65nkKz2lxbLXId4/Sk
 7W8tFVSCrdm0ZKPUEPHSopF7XkQXqFvGi6kFRT9epMiG1wpvIYNYIsOauov7a69UxFpWm2csMu2
 QOjNoTV8mchoyX2uDgllYZLLg26QA4twpDmMSXsgxnakNcAEvgCgan2c5IVQbjLRsKQpdKcqnOn
 eiaUORFrwslwhPva0Lb/h6KQposr+ofYbtQFvIhO+JYvdTsHSW7sQkhY6SlLmPzBIIdfhTd42Kg
 YfMWXg8am7+3umFZkTj/gd+RC0h1JRmAnKIQhSXVbwhyCHUC90o7IaxMUaf8qaxD6y+3hTJSLzW
 ODUnldWO78p+w51vV4oxnU1oTcEny6Opux4dVZMs9BLT6giGHcxR66iiq9LTcLzZXO4rBCbbSL9
 zlU+mrkMGjVpxgUkYI0650oGmeRw==
X-Received: by 2002:a05:600c:3b87:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-48350836495mr26695935e9.36.1770716673675; 
 Tue, 10 Feb 2026 01:44:33 -0800 (PST)
X-Received: by 2002:a05:600c:3b87:b0:47d:4047:f377 with SMTP id
 5b1f17b1804b1-48350836495mr26695535e9.36.1770716673227; 
 Tue, 10 Feb 2026 01:44:33 -0800 (PST)
Received: from [192.168.10.81] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4834d5e1a8esm45791175e9.5.2026.02.10.01.44.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 01:44:32 -0800 (PST)
Message-ID: <f5cfed0d-3425-4bdc-90f7-1dd2fa33b448@redhat.com>
Date: Tue, 10 Feb 2026 10:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] json-parser: add location to JSON parsing errors
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260107084840.150843-1-pbonzini@redhat.com>
 <20260107084840.150843-6-pbonzini@redhat.com> <87cy2d7y3y.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87cy2d7y3y.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/10/26 10:21, Markus Armbruster wrote:
>> - *
>> - * 0) make errors meaningful again
> 
> The errors weren't meaningless, just bad.  The "again" is kind of funny,
> considering it's the initial commit.
> 
> I agree with removing the line, but i wonder what exactly improved
> beyond line and column ("geometry information").

I think it's more of a reference to the error recovery.  There's only so 
many ways to report errors for a grammar as simple as JSON.

But just for kicks I looked at the very first implementation and the 
current state, and diff-ed the errors.  These are the differences:

renamed:
"expected separator in dict" -> "expected ',' or '}'"
"expected separator in list" -> "expected ',' or ']'"
"missing : in object pair" -> "expected ':'"

removed (merged with "expecting value" or "premature end of input"):
"Missing value in dict"

split (out of just "expecting value"):
"invalid interpolation '%s'"

new errors:
"can't interpolate into string"
"%.*s is not a valid Unicode character"
"duplicate key"
"invalid UTF-8 sequence in string"
"premature end of input"

So I don't know if they're "meaningful again", but there were some 
changes over the years and the current set seems good enough to me!

Paolo


