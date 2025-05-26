Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AD0C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 06:08:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQzq-0008Sx-KQ; Mon, 26 May 2025 02:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJQzo-0008SZ-CZ
 for qemu-devel@nongnu.org; Mon, 26 May 2025 02:07:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uJQzm-0006DY-EP
 for qemu-devel@nongnu.org; Mon, 26 May 2025 02:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748239651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WhCwe0EKJ5WlwSow63eQosYByMekr7jawLBeiKLpZk8=;
 b=cnYl+Cn5zo5Sq7tNhg44nfU86cjiPKL9f/DuLtoO1zC1kOwKHYIZN6G47h0JXnNoWU0WfD
 6LUX4STPzbVe6eEVZ1VhLi8f7K7DRQ2l4I+r6ybQynxxOrIM1cluUjetvs9L4xp96Nuowz
 AsRH8J+uvTn7WvNWxO8ibtZLlcPXtFk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Ja2idPMDPx2YnPgzN-cTKw-1; Mon, 26 May 2025 02:07:30 -0400
X-MC-Unique: Ja2idPMDPx2YnPgzN-cTKw-1
X-Mimecast-MFC-AGG-ID: Ja2idPMDPx2YnPgzN-cTKw_1748239649
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad5697c4537so150397266b.0
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 23:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748239649; x=1748844449;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhCwe0EKJ5WlwSow63eQosYByMekr7jawLBeiKLpZk8=;
 b=XL9PL/kqsKuvfGVrg0M+SYOKPpGNRfjwN+n3ApZ5nvq8n9tUBdywp9HBdyt5RBIscw
 JH+luz87jL77SZSHaN05XszwzSEfKiyJO/EXdidPls2KKpWZWdMSBQvvS25mYXXym5FF
 Y5+7NeqFNVKQ3Z1JinlX7ANN7kE+1biWaskm79r/O7fzTlWPGsO8/nxBgwTKgx4rDdv0
 SwlC/rwUKu4atRTBmSVRjC1DloeDFjgAArVMF2DfU6LoKRtisEGYHwjrPTKS9jmNMdBg
 D0TBVR6D0bUkITQZmkZAqPvJkdDRW+SmcAaQRMTaGAcCRGKS1nvismNykQSsAOsWI0NJ
 rVuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr7GgKL6zNxc5/riWdXjFKsCZlIfLyoZ/SxrzifW8KIZuhZ6HAZGx9YfL4HJxhKCcrk/kGnr3vo6mZ@nongnu.org
X-Gm-Message-State: AOJu0Yz0+T3GzK8EkshgEF/SwuE3CYP5VZDQsHVjRUPuldp3/ubJXmkS
 Yi67bHSQpkd33YwVJcIXcV7coBl4XDkqVHWLbitUkE7g6c4GIufesO3S+VmexyGbiLwqDdxb/4O
 0ee3OHGAxoV+82yi/l+T/MOFV8kMO9poqUSI1cMSk0qxjv0mGwTXdcVWK
X-Gm-Gg: ASbGncuAG3iN2Bd93TKKWzWc/9c0cirtz0t32BaWTpnGWjxSVj2k0mX5wnf+A4rz4KS
 eKmkssFLwYyVWV2+MBNbnbWBC7tWuhLVDCMazpyEOECYyz6sQiTLieizFaeHfrG9ENqCoX5aH8q
 NON3tN3ZT2dnQXMC9SCiK8z3DbxWjv73Rn8WPynBYFMVPQGCMvuB57YAbRZIobi2zqYQ3MrO0LK
 GFtHLhPaFeA40XXwMOZV0eQu/By0KuZhCBGYTiF5Z7yhPPYZaaW4Z9CQIo0LU2Oq1ksLfwjt8ID
 6xvw9nRaOlKJOViu7cmrWuqnRXE8TQPdToRyYBlY28g=
X-Received: by 2002:a17:907:1ca3:b0:ad2:242e:fe9d with SMTP id
 a640c23a62f3a-ad63f9d7ce5mr1118673766b.10.1748239648906; 
 Sun, 25 May 2025 23:07:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOagGzIlS71tlOyzD6ZLOgeN5BZ4oT8LCfzzF6Q8B9sjLxLkVZNYzc6y7QfEY132KJgQ2UTA==
X-Received: by 2002:a17:907:1ca3:b0:ad2:242e:fe9d with SMTP id
 a640c23a62f3a-ad63f9d7ce5mr1118671066b.10.1748239648515; 
 Sun, 25 May 2025 23:07:28 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-201.web.vodafone.de.
 [109.42.49.201]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad8741d84d2sm138678366b.157.2025.05.25.23.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 23:07:28 -0700 (PDT)
Message-ID: <11b5902e-34b9-42e5-ac6f-e2ae3e74a598@redhat.com>
Date: Mon, 26 May 2025 08:07:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] qapi: make s390x specific CPU commands
 unconditionally available
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: michael.roth@amd.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 armbru@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
 <20250522190542.588267-11-pierrick.bouvier@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250522190542.588267-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 22/05/2025 21.05, Pierrick Bouvier wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> This removes the TARGET_S390X and CONFIG_KVM conditions from the
> CPU commands that are conceptually specific to s390x. Top level
> stubs are provided to cope with non-s390x targets, or builds
> without KVM.
> 
> The removal of CONFIG_KVM is justified by the fact there is no
> conceptual difference between running 'qemu-system-s390x -accel tcg'
> on a build with and without KVM built-in, so apps only using TCG
> can't rely on the CONFIG_KVM in the schema.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   ...machine-target.json => machine-s390x.json} | 16 +++++---------
>   qapi/qapi-schema.json                         |  2 +-
>   include/hw/s390x/cpu-topology.h               |  2 +-
>   hw/s390x/cpu-topology.c                       |  4 ++--
>   stubs/monitor-cpu-s390x-kvm.c                 | 22 +++++++++++++++++++
>   tests/qtest/qmp-cmd-test.c                    |  1 +
>   qapi/meson.build                              |  2 +-
>   stubs/meson.build                             |  1 +
>   8 files changed, 35 insertions(+), 15 deletions(-)
>   rename qapi/{machine-target.json => machine-s390x.json} (85%)
>   create mode 100644 stubs/monitor-cpu-s390x-kvm.c

Reviewed-by: Thomas Huth <thuth@redhat.com>


