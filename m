Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85675D49C71
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 08:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vljvg-0005je-Dy; Fri, 30 Jan 2026 03:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vljvb-0005if-P0
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:32:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vljva-0005EZ-Gl
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 03:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769761949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6uem0GMFINleCYAZHZEvWdN5YkGPM0aZVo63JOVWj1E=;
 b=d3A6CRMlo95BftKg+ihU8ohaJcoQVeFUmXUuGP4GhXBmb/S84Gb/tNjbdhYtBbU7gRiVaj
 ejhOqBNCrpT6T1LgtC79QWYykw87gnhyblzZuO7qCX4rkMorKPeUl7mXSGPUe2ZTJjaw8p
 qwR6EzpGvUhidMNSp+wFBohqnLJsZZo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-Zq8Y8nsHMc24Gc1MBK-BEA-1; Fri, 30 Jan 2026 03:32:27 -0500
X-MC-Unique: Zq8Y8nsHMc24Gc1MBK-BEA-1
X-Mimecast-MFC-AGG-ID: Zq8Y8nsHMc24Gc1MBK-BEA_1769761947
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4806a27aa31so18675595e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 00:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769761946; x=1770366746; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6uem0GMFINleCYAZHZEvWdN5YkGPM0aZVo63JOVWj1E=;
 b=SGeJDTQYdDOdR/tPhYXixr7nR0PRiAy34wnZzwXyrimkfdjeqLNcthpRCeDR1m+VYA
 mm/RMUw0dZeLbcJijXZYKo6CIlGUZeCufKDRGOQbpP8qlmc9X4d2wEagWHlYQJFFYZNT
 aVpoFFgvhMjhOViIae4RiIlREX43p8Xz5c8VwfAqCen20Wmq+7KvFiFNCi8t+O3uB094
 OcRCtEbLiuTuuFAz8F/dlzBEgsJ8eIbR/L7aMyt8PTwEF4Gwl8grkU+GWxtTXB8ZjR1r
 f5Zp9axQG1Qp/BPJnp2Dihb68wtWrD02unWDoXKdFLnRLyTPtvgeHzcsUzgnU8VxC0s3
 Dl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769761946; x=1770366746;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6uem0GMFINleCYAZHZEvWdN5YkGPM0aZVo63JOVWj1E=;
 b=IEX5qpJNdR3GRvQf+w2iHPuR+L8rcL9T+Ky2h+gIRSQkgDr/P8vnFQnrrULPcemQQr
 1jfXMf58960cn7VklpxEcvB02VtYmnWHbkVKKH40zRRGa24uVSLD1PWrTllN3z4bOy1E
 6Ye+ZYCcM8OoGVkAsg5JGJML043Op9VjYOUKslyeHKtb629npb+Oer54Z+ZRRyxNaaAA
 0EFQy5A4mSxi4lIA195+PgWjN+0zXQ8OjFCbYQ9jEk9B2/uV5NM5kV86ZzPGWgrmmbWR
 Hpx+ZMCB/VUmPNlr8r6w9pZMO+adfQ4nADaAPhKk57FIbeR5aL7liM9Vz2L4ysfIjxnh
 bXCw==
X-Gm-Message-State: AOJu0Yx4TsITYy6ynJl/8xBXWTwYiYkWQBdrD2rU1wLYUxM9oY6mRDR0
 AaTpFDUp7G/oQCyJdjuLbtcRWp4IdVaruSXVYB6Q2+mRq8YjWGd8jZfIl8upkBmhpCEQNFQ3T/H
 auRSr15b1ROM/Q6zhQla+dc7hh1tutdtseyQPdN7MDF748r4ARBwGJA5+
X-Gm-Gg: AZuq6aK00ipNA1leM9BRMWZycpDUiXpJJYczQjJGtH8qQfBr2cTjCXXkaZGUEH704j2
 kEUOiluymgR0+W+1Jgk+JaZ9h6WJQ3pOH2PtsVR44LeXCpEC5wqSDaJdB7IVcTFx0zmw1IfUb4O
 wHnwo7f2AGxqg39DmNHt4/JUySj1miBuzWgnaPqdDpM0+MzgQjZ9iyA6vpjIkBemNGds9Dum199
 +S+y43voqvRvCPG/GGIuELQB6Z3HcnvzlzdTmAT83HF72uPj3xDtI3bVNX+N3B+qFyLeuDhBTnL
 EB3vPb0smJOwEbrjGuiD+dM42Bf0YVetF94NqumxvnjuZIdlw4inCRAH8NHed9sjX7nvxtYAMVN
 GDCT7whVBJiHb9xuyfml6jhvZdkzPSptMn/ZYOfB86PjkOiIoQ4BW1Dw+LlkYAxC6j2aLEgSbNy
 bhMNOl+zOMx+naoA==
X-Received: by 2002:a05:600c:1549:b0:47e:e779:36e with SMTP id
 5b1f17b1804b1-482db49398dmr22521105e9.19.1769761946499; 
 Fri, 30 Jan 2026 00:32:26 -0800 (PST)
X-Received: by 2002:a05:600c:1549:b0:47e:e779:36e with SMTP id
 5b1f17b1804b1-482db49398dmr22520785e9.19.1769761946133; 
 Fri, 30 Jan 2026 00:32:26 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4806cddffe9sm255050835e9.4.2026.01.30.00.32.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Jan 2026 00:32:25 -0800 (PST)
Message-ID: <7b5a7de2-1cec-485a-b9af-f78eea7621cb@redhat.com>
Date: Fri, 30 Jan 2026 09:32:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4 qemu] Avoid static definition of copy_file_range on
 GNU/Hurd
To: Damien Zammit <damien@zamaudio.com>, bug-hurd@gnu.org
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, manolodemedici@gmail.com,
 stefanb@linux.ibm.com, peter.maydell@linaro.org, kwolf@redhat.com,
 berrange@redhat.com, eblake@redhat.com, bugaevc@gmail.com
References: <20260130031954.1661880-1-damien@zamaudio.com>
 <20260130031954.1661880-5-damien@zamaudio.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260130031954.1661880-5-damien@zamaudio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 1/30/26 04:20, Damien Zammit wrote:
> glibc already has this as non-static on __GNU__ systems.
>
>  #ifndef HAVE_COPY_FILE_RANGE
> -#ifndef EMSCRIPTEN
> +#if !defined(EMSCRIPTEN) && !defined(__GNU__)
>   static
>   #endif
>   ssize_t copy_file_range(int in_fd, off_t *in_off, int out_fd,

Do I understand it correctly that it has the prototype but not the function?

Thanks,

Paolo


