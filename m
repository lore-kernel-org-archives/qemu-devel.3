Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6D9C5321C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJSe-0001kP-6n; Mon, 27 Jul 2026 07:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woJSa-0001k4-Hu
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1woJSY-0008DL-Qd
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785151525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jiMQTLtuvb2uYlzdguXxTNXiZ/hc7mxKLyBrNxI0gnU=;
 b=IG4yyglGUVDQmIGrHjqZdlJ6H1bjWz9rIwO2TQJGKN4e+EikNHLK/J1YDi/luej2DZE6tB
 UmLgpwwS17ihKgUpJ9MWdvVemhNSOwlUficOl+7Rv1jUOx24x5THT4a2YY5JZlRtbt5tCL
 +bmQ03P1BOu1MnZRw7p0hX+XBFo77eo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-Gy8tjoaBN8K7hxDtJ0C7rA-1; Mon, 27 Jul 2026 07:25:23 -0400
X-MC-Unique: Gy8tjoaBN8K7hxDtJ0C7rA-1
X-Mimecast-MFC-AGG-ID: Gy8tjoaBN8K7hxDtJ0C7rA_1785151522
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4957287363bso16946665e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785151522; x=1785756322; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jiMQTLtuvb2uYlzdguXxTNXiZ/hc7mxKLyBrNxI0gnU=;
 b=CA8L0kJZVC60/3iWyI5DfQjppiLwzekMBFAxgKg7wtUOlYvSKxf8XbxXCi1qZRb6G7
 GZF0NuBmjqYSxDUdjPYBnHXGgWDiyAe6AiNG9M3dsHokOQqdUYwCvZ0yAYb6hxhntKdB
 nGkQkDu9HxDprCtThYVQRYKXXWWq1SgrVZzr6yA2/P0Vrybrtv7m7WwIhCfTDSQMZ62q
 5lrrqGzpLsLpPLZp8ND10SaogxQ6N36Ayqr/yii9KJtqtmQqdqoMFEYd8nl9iutyy0ry
 TF7OWBSUkqezdAJECjvB7KZ34i75HJWEXYJJhBf0N9voy/D2ugt9WbvhlgOWQOshFOor
 nHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785151522; x=1785756322;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jiMQTLtuvb2uYlzdguXxTNXiZ/hc7mxKLyBrNxI0gnU=;
 b=l6QALhYyKy+wZAxH7N0hydnyBV90yhNQU/Ch1tv70k4G5vs/ZARJb9Rui0nsb7H5j6
 Jv6C/3zmAwhvruwfyLMAbyu3PNZPTVDh9HXKkaAM5Z6daJuX7Hl6KiNeBS9PXJAn9nBK
 XBcnylZfVBiMQ6ktzfQ4MqSz0pbYA+7rC3zvyTYzBWsuU90qhv6mXo9AcnVPxbgHz8Sf
 FrTr52VYv3UnKvT9etsFGZkHz7oCh9uf6mqqZCReFvTxl01F7zWFyGPQdcPKIFOrtzgu
 xkp/sXFq5x073oWBgtagabbZ1+ijlz4v+Iwe+C8b9gb5KfLkh+wd9w5hBcTH/0KRNZkD
 EgXg==
X-Gm-Message-State: AOJu0Yz+NlWQ5nNPEoPzp0few87lrKtZb08qJPJun0tzDywrHMo4yjFf
 0ecEwH3oCUW8qLxi1dPFpaBhe52OffpklzdVmB/Y3HVbUDfeViTfphQwXihXbHgnPwbupzCHzmZ
 j1+g8P0m6kCVTK66EpdNCI3mCyj97xcm91M3Y4o/7/87ennvEmL0P01+O+pBEHABJ
X-Gm-Gg: AR+sD10Qk5FgdOPDC/q/J+hkXdaZm9rHALulIiU5455H1KohSQi8GNAzTnn6nHSXpQX
 etBuLCTRyMq39gbbBKcWw7bsi1Hbrv92S6I1uGhMNXCJFMMBVF0JVf12uEBGctbIklSKGzmh8dh
 qubX7Bbf8jvWwSdiePn7Agk+DRiEcHqaLFbKRrklLaW6GyrK2KTOjmlx8NYVP0G3/jTIE2o0ZPp
 dyJzph72quYxPehOL9rv8NnSO/bnViV4lDB09DZN+JaQRiiUvWu46TpWa8VqjXG1u4ZlnQT9K4/
 zXxZmEIIX57rIjk72dgJbbZwkJ8Os3d1OSiP+oomWbS0egIbA6H9b7kh4bxI32ZaeAXvhGDLPq5
 qBa4p7lvISJfb5e2KKZv04jRMEmw8iKUhqwgGdJ0=
X-Received: by 2002:a05:600c:4ec8:b0:495:3f68:699b with SMTP id
 5b1f17b1804b1-496b56f3705mr104684325e9.9.1785151521899; 
 Mon, 27 Jul 2026 04:25:21 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec8:b0:495:3f68:699b with SMTP id
 5b1f17b1804b1-496b56f3705mr104683855e9.9.1785151521364; 
 Mon, 27 Jul 2026 04:25:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b485f65csm213339355e9.5.2026.07.27.04.25.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2026 04:25:20 -0700 (PDT)
Message-ID: <79fba193-093f-4c85-9a92-2d69ef5a229f@redhat.com>
Date: Mon, 27 Jul 2026 13:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/checkpatch: validate Fixes: tag format and commit
 ancestry
To: Michael Tokarev <mjt@tls.msk.ru>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu@processmission.com>
References: <20260723065320.1314072-1-clg@redhat.com>
 <7e4a2ca1-c930-408f-a39d-d926bd8ba788@tls.msk.ru>
 <6e54009f-2e84-4a22-9316-b0db8f9a1d1f@redhat.com>
 <CAFEAcA8SyaLgY1boJMcemOdGqArktkmZJiNugi4PuP5Kd5ZHRg@mail.gmail.com>
 <9abb79be-1a98-44fa-bba2-2e0f8b4841b2@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <9abb79be-1a98-44fa-bba2-2e0f8b4841b2@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/27/26 11:28, Michael Tokarev wrote:
> On 7/27/26 12:24, Peter Maydell wrote:
>> On Mon, 27 Jul 2026 at 07:14, Cédric Le Goater <clg@redhat.com> wrote:
>>> Linux uses:
>>>
>>>     my $git_command ='export LANGUAGE=en_US.UTF-8; git';
>>
>> Does that work if your system doesn't have that locale configured?
> 
> Yeah, I had the same question.  This is one more reason I think messing up
> with locale might not be a good idea.  Maybe C.UTF-8 would be better, b/c
> it is often built-in (but not always).
> 
> Also, LANGUAGE vs LC_ALL.
> 
> I dunno why linux kernel folks choose this.
> 
> And I already explained in my previous email that it feels better to
> use exit status here than to parse command output.  Again, I dunno why
> kernel folks choose this.


So both of you would prefer:

+sub git_commit_info {
+	my ($commit, $id, $desc) = @_;
+
+	return ($id, $desc) if ((which("git") eq "") || !(-e "$gitroot"));
+
+	my $output = `git log --no-color --format='%H %s' -1 $commit 2>/dev/null`;
+	if ($? != 0) {
+		$id = undef;
+	} else {
+		$output =~ s/^\s*//gm;
+		$id = substr($output, 0, 12);
+		$desc = substr($output, 41);
+	}
+
+	return ($id, $desc);
+}


It's fine with me. v3 ?

Thanks,

C.



