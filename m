Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85586C54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7cj-0002bs-Ug; Thu, 22 May 2025 11:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uI7cY-0002aE-3N
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:14:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uI7cU-0006vY-AO
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:14:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747926842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUU1vrB6K7muaVtxkPDZ/zsZBWCAMJCIos6LlhjeG4c=;
 b=hDFr4paUT6fDwj+p/Lx4zH3ksZHT+WikbUB+I5hCwToK6i3CTdogVXQM/RKYJzlOY0s1tk
 +cegcv5WiW9XNIeoGYQzU/UMMrE2zl5S/9v9sKw7jBRD7I3EPxc8aUOQ1oq7/IFAJjyZMo
 HZMdGmMuMHPkHVFH+SLN8PjWsqnZz80=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-Th85qgg3PWSMVvve2fzAjQ-1; Thu, 22 May 2025 11:14:00 -0400
X-MC-Unique: Th85qgg3PWSMVvve2fzAjQ-1
X-Mimecast-MFC-AGG-ID: Th85qgg3PWSMVvve2fzAjQ_1747926840
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-44a3b5996d2so4922755e9.1
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:14:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747926840; x=1748531640;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUU1vrB6K7muaVtxkPDZ/zsZBWCAMJCIos6LlhjeG4c=;
 b=mWUkLODzvPZSjUt0FQXttcfwRAU0Ytp9o0NhZ66rIFt4BAfAkwHstOOqO+CjKVP+fG
 eiklGW1WMMCTutvaPk0nLOEws7qPX8zaHC8K545xqFtcuv/9Fo67O12Wz18/jWxZA6FZ
 cpQRm1ZYrA4XWY/jZRnKcfF4AY9FqAEbWUQjg46vIxv48gUq+Nx+SBhvNfmWV3ANgxRF
 UOOhH7nNr4wJLO7aOYd+EWNgmoP1+QWf4SN2hdyhOJXcnqUhrz/DSVutmhaIZPYaD+AT
 +5Qc+A+WstAW24qRZCvUv2nw9MSyjp638sDu1cELpKoDRIjWgc1neAmSO1d8VlBJZOYL
 zC+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgu20ha1etrOoRNiREKAgh8ESn4kv/8k6cX29fOYRbBUFGWC2cHVubFS1X7Q8hene1UhwLNpmhauRM@nongnu.org
X-Gm-Message-State: AOJu0Yxnw60tQ7vZ+uRUfCgC3FEj3yPU41zyTKE5LysmPREM5SM3AX9S
 eej5jbu0dUCQjq0JaCqW6iTHDGuvUIdKhxDFIEpcsJVKG3DVU9W/Ca/rlJ24R0Dt8D65BBmTXB4
 GtzM3x2yEri+G2+eqNqLiYx9WeATquIrVAzkD2ZQWcPdnN0ztdEaD/jKQ
X-Gm-Gg: ASbGncuNye6CYhPRhV4AIq9rhXuXmaInaTrkXfxenUP3L0acbddeS3p97UmloU5CPF5
 Uo4R34LB/q8177QZCx0lRVvOyaEVh30j/oslGUjtzvIOnZ9wf8i6yz+kLTRJ57OHvw+Hpx1No9m
 Q1EPOuAdBO7ACRPpWya0sMbJWDGe9NLbDcKsJWBA8EH3A/7XsbwNggXysxwb/fvDxqFX+GNH+tq
 NnTeMVPBJS9KbBFB7hu07sTfIRXDnnGX1pzm2JjB/4QGKEwFtrxjdw2RuSDFNUJY6uWXseSnAu2
 pLvUWY0Z2YW+IFb2K5WvKNBPf5zSZ2KE4aiKwbYpWUrJma3Id61hua1hOxmUtinbj28Oipula8R
 OWE1bXeTsCC2PFEN2Ep1/Wc12kZX0S1NmvQxhE3P6
X-Received: by 2002:a05:600c:64cc:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-442fd664f7dmr228301555e9.23.1747926839569; 
 Thu, 22 May 2025 08:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpX6SmlXnyeAAlYMUzeFf5LcuHt2mu2aF4Oh4uRWgjDT1nJJ8eJWP4VhzgKML7UT8XLGHfBg==
X-Received: by 2002:a05:600c:64cc:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-442fd664f7dmr228301015e9.23.1747926839135; 
 Thu, 22 May 2025 08:13:59 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f30f:4c03:bf99:79e1:4b96?
 (p200300cfd700f30f4c03bf9979e14b96.dip0.t-ipconnect.de.
 [2003:cf:d700:f30f:4c03:bf99:79e1:4b96])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442ebdc362fsm235147765e9.1.2025.05.22.08.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 May 2025 08:13:57 -0700 (PDT)
Message-ID: <fbb8a262-10c5-43a5-bb99-a3a1c2a33714@redhat.com>
Date: Thu, 22 May 2025 17:13:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] file-posix: Probe paths and retry SG_IO on potential
 path errors
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: stefanha@redhat.com, bmarzins@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
References: <20250522130803.34738-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250522130803.34738-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 22.05.25 15:08, Kevin Wolf wrote:
> When scsi-block is used on a host multipath device, it runs into the
> problem that the kernel dm-mpath doesn't know anything about SCSI or
> SG_IO and therefore can't decide if a SG_IO request returned an error
> and needs to be retried on a different path. Instead of getting working
> failover, an error is returned to scsi-block and handled according to
> the configured error policy. Obviously, this is not what users want,
> they want working failover.
>
> QEMU can parse the SG_IO result and determine whether this could have
> been a path error, but just retrying the same request could just send it
> to the same failing path again and result in the same error.
>
> With a kernel that supports the DM_MPATH_PROBE_PATHS ioctl on dm-mpath
> block devices (queued in the device mapper tree for Linux 6.16), we can
> tell the kernel to probe all paths and tell us if any usable paths
> remained. If so, we can now retry the SG_IO ioctl and expect it to be
> sent to a working path.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
> v2:
> - Add a comment to explain retry scenarios [Stefan]
> - Handle -EAGAIN returned for suspended devices [Ben]
>
>   block/file-posix.c | 115 ++++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 114 insertions(+), 1 deletion(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


