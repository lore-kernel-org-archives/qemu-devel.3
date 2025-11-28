Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BEFD116F1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 14:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOz35-0007WW-Ul; Fri, 28 Nov 2025 09:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOz33-0007WG-Ti
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 09:02:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOz30-0004xY-I5
 for qemu-devel@nongnu.org; Fri, 28 Nov 2025 09:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764338523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=e3kpNUtU5OTG20p8YaYaAeLYkFyKHdoquJ35eVYIDAk=;
 b=KnSwKQJFhMD8IsWpSHw9M6D08yMvckgwuOhMLlHcE6UGz5RSjzsjuxXZfIyYiAGWRIFN75
 Y1V5pKs+BWx/znhLKY1AqJygy4gX/u1EpSPMvDIy04SHml6htPO/36raFAXoW4/Qi7BXjD
 knGc8PZrYLClzb99J+g+8kaowxQR9EY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-411-qf_Z1b7vP-uZRMsNbN8hgQ-1; Fri, 28 Nov 2025 09:02:01 -0500
X-MC-Unique: qf_Z1b7vP-uZRMsNbN8hgQ-1
X-Mimecast-MFC-AGG-ID: qf_Z1b7vP-uZRMsNbN8hgQ_1764338520
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b763bab126aso193848566b.3
 for <qemu-devel@nongnu.org>; Fri, 28 Nov 2025 06:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764338520; x=1764943320; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=e3kpNUtU5OTG20p8YaYaAeLYkFyKHdoquJ35eVYIDAk=;
 b=MWjJKeF/Q50qr2awL2zVhO1fpbDri9tVUmaRJ4qHV9e2zblhTUPddzxFt/Efwyiv15
 6fz7FelZ/I/bu3xUoyCRw2zf7MX26OdXrM9RLG7LML5URDi4lzSTq7COFkkuerFtVoXb
 YgLcUGHqb1rHzPKRxBjToHw4p3RKIc1qel6T43UCuy1Ss6iP+Mi21KjczpAVOmTh3eUR
 TNHHAwWkGaMCPLy/M44ESSTxKFTo/8BPM0OnRDdRGbIUGANNR5UY2IDoG9YjaeKm9t5f
 4W8TQoN74Kf9kiprcDhx/CqgPf8lm1FIypFMJsGrDug/WvIPxynAYEQuYG3DtSgD2S3L
 Tk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764338520; x=1764943320;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e3kpNUtU5OTG20p8YaYaAeLYkFyKHdoquJ35eVYIDAk=;
 b=UqVnPv70dJGfS+LhlqKhnM71b1MQRQ0KER+9xb+gL4jLMOAgHH982+RrszayNk6KOP
 NsJDAzwzDTYvw7R2tUWWLW9gxCQVGQaeBc1vgV66j2f6/YlkzeMlPOMs4vo2++B/iQDG
 SyxnnArvcb9/t+8onHZ8I4cUsKuigfD9zCmt/x3RMwCv7u7Fnt67b7epQ2w4VWF/vdyn
 SomUBCuE0Tc9dyyui9mISfeGkDo1cVn58Tiv3EmdiFVzq6obE5gO001Go4W0qLgUAfjD
 sw30AJn+MiRfdUy4V7+oKd242g5fTGihhfgq6yVvux7CODIgfN7CQVroNmUZXoMQfCaB
 S0TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSUuL0z7gu/urtsYuntia7wjtadUUudyreThE8AOleb+d1b1TAlL4Usbqd3PJRi+ljMXyuwpMgm/qg@nongnu.org
X-Gm-Message-State: AOJu0Yzc3WGP7TtT+SaIoUdTIr9ASe/Anm8fW8tpi1P8FfG/FtNRxiLi
 iee55eHdxmr2xk3VofoyvITYnR90iy6eOLpy9MzzhMa5p21mRCIi2y2zr7PJJo1Ne5l7TylCMh2
 vD3WKyBPyhOKsewet/RryTD6ktm1KHSbYBCZWLEj6hLuT/2UXjKLtJNzq
X-Gm-Gg: ASbGncu54ld5/7bb4XaL8wOw0x97ho/4BlwC2ERwPquAjRDh4raEuyhfGk7QKiZaH16
 5qW/rBwc2mpCEkwilJNQ4PbXUlg+XQp3mo2TAr1oPuF5SzHPMDkjbnVRLq6bERUebB/EmMiHVGN
 gP2tvW4MoqPsrfhXKj0jqlv9CvRY1TvMdY27GLMkx+89a+g5fYJWJnIFtfg2h2lwujU/Evfn5hX
 XHoddxIeyVxURxORmJ9cLjv5vUf4q9MoJLKlV/oeq2zHQKP3IkMMT0MYmoaG5D29MG0+pJlXK80
 xz9B4BGLr+3bE/tOJU8T/tNt016HB5mXVKeT64TF78D9vEDTESEzpiqPUmoM9+UUtTunDT6MHEj
 Xo+TnhCI=
X-Received: by 2002:a17:907:9450:b0:b73:9be1:33ec with SMTP id
 a640c23a62f3a-b767153ede4mr2734031266b.9.1764338520167; 
 Fri, 28 Nov 2025 06:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFxfhq0zSB69iNxd0yH9JO5PtiX6+4JPJLXYMcz6cDAT1Uaf0NEk+RMNBAgSttAZQO2EoPYA==
X-Received: by 2002:a17:907:9450:b0:b73:9be1:33ec with SMTP id
 a640c23a62f3a-b767153ede4mr2734025166b.9.1764338519550; 
 Fri, 28 Nov 2025 06:01:59 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64750a90d73sm4362658a12.13.2025.11.28.06.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Nov 2025 06:01:59 -0800 (PST)
Message-ID: <50e4aac5-0279-48be-bbcd-1957069d0cdf@redhat.com>
Date: Fri, 28 Nov 2025 15:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scripts/device-crash-test: ERROR_RULE_LIST garbage
 collection
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: jsnow@redhat.com
References: <20251128101321.3287186-1-armbru@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251128101321.3287186-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 28/11/2025 11.13, Markus Armbruster wrote:
> Device 'nand' was dropped in commit commit e86c1f967a3.
> 
> Device 'vfio-amd-xgbe' was dropped in commit aeb1a50d4a7.
> 
> Device 'vfio-calxeda-xgmac' was dropped in commit 8ebc416ac17.
> 
> The last error messages matching r"images* must be given with the
> 'pflash' parameter" was dropped in commit a2ccff4d2bc.
> 
> The error message matching r"Option '-device [\w.,-]+' cannot be
> handled by this machine" was dropped in commit commit db78a605599.
> 
> The error message matching r"Ignoring smp_cpus value" ceased to match
> in commit f2ad5140fa5, and was then dropped in commit 72649619341.
> 
> The error message matching r"rom check and register reset failed" was
> lost in merge commit af3f37319cb.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   scripts/device-crash-test | 7 -------
>   1 file changed, 7 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


