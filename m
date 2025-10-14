Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378F7CCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ka2-0007Ng-Pa; Tue, 14 Oct 2025 15:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8kZu-00076r-5h
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8kZn-0007rd-Rn
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760469650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wd+FSx71nECHST05mp2q4OyfMPeR58ApNGXGB0SWY2o=;
 b=ZeZ4LTUg/ifUb0H/5AMmnSVCyEqCSDqQg3cnkCkknjApdPI3J70mOfQIWKy94J5yF/Iv06
 OigXxegSzXRJP41cVT+mUDT9Yyw++EkLKiQX19/M01SOem1CimT/XYGzj3z/4mWIYm3QR7
 lFDglD6lRO9aCzsGrRW24xl5qBnRg0w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-i0CXF3USMUiWrs0p2Fx_ow-1; Tue, 14 Oct 2025 15:20:48 -0400
X-MC-Unique: i0CXF3USMUiWrs0p2Fx_ow-1
X-Mimecast-MFC-AGG-ID: i0CXF3USMUiWrs0p2Fx_ow_1760469647
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f42b54d159so5868477f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760469647; x=1761074447;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wd+FSx71nECHST05mp2q4OyfMPeR58ApNGXGB0SWY2o=;
 b=W38TX45gP6Bz7P3JW6ee5vkMELdoIG1SHI108BLJBY74ymyFcgfO3TM+yyiIKWPYhP
 FeZMiCm4qdKFoLiQJnzM6a5T1DSQ6z+E/diq3SrPW5uaTf9zxuQwmw7AyI37X7sj/6cI
 H90dFQBWDSOV6xkp1Kp3wXSDdaYCFDDe7l3FPB0PTH8KJhNpo7Be/50zvsyWNMKrIuQO
 4QSP9UNAiePAQEvEXTlrzrXFH2CDujUzE+UyuJGAHQ1WI/HSaNPyjeyLjyHoqeGgKYFx
 Kx53gbFn+VaDXFQ/z2VUuKqetjb+DRxyTbYJ5uYbdSkE03B+KroEgghQaRONNwoF0Q97
 fuEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKH0Z9e7KSr9EJhwFOYWpWy2L5jthdKrgpSS8JlKF3YIGOXeq9zg8E1CsEVs82+dYVFb1MTg/0/38X@nongnu.org
X-Gm-Message-State: AOJu0YzdS1au6qZw7amK/gInhc2eQ8jIaq7iYBQDqWk4q92wk9OS8evP
 /dHRRpZ+oesp4TDnnc4TehBdo+O2W6B/97IGT13twhAaP19DfQ6eL8Y9O/OQy15d1qckm8G7aoW
 H68FJJVadER6lXQ8ZabXbNvazBsxw7mwu4sAIa2GFS6kv1ueDgM/AeIXG
X-Gm-Gg: ASbGnct4dbctyv/kukwIk3CVmcsvu+wuljUE0mz0GGQxt2pxoOY8IktbOhvMBV51/Jl
 sEgPfz+ItPBU4hXCXVwz4NVSGm3lJ6J1+P++LaLki5//OZSKwlhVRnubijOxz1mD7h/1hP6/ZNx
 bjbjii1oF4Cd6fNd3EpAw1rxuUk/Usek9/HO72aL5NQ67j18H9lg9/egc1+0S/6yRrIBXPhJ9Zy
 JibgxfHlSB2lHz7B4Jh2WYbMMXRwEMcuDalc5gXQLCIZT1U17N2XheDanO29ET+7hHVo63Q/okE
 3iFeRI8J8BvlJWA6rudDK9XticS+lJtfuUKdlpqSUh9q0Xe6E39H+t9SWAYq3HIEHjaz0Y20lOY
 yFKo=
X-Received: by 2002:a5d:588b:0:b0:3f9:141:540c with SMTP id
 ffacd0b85a97d-4266e8f7116mr18054805f8f.40.1760469645804; 
 Tue, 14 Oct 2025 12:20:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZLG+6QqjNkzM4qJ6LvtJzmXqDaXxlLxCiI2P6Sh0NI8heqbis5Y9hbRFN+OAZWTXHSUlGjQ==
X-Received: by 2002:a5d:588b:0:b0:3f9:141:540c with SMTP id
 ffacd0b85a97d-4266e8f7116mr18054783f8f.40.1760469645276; 
 Tue, 14 Oct 2025 12:20:45 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm26196099f8f.10.2025.10.14.12.20.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:20:44 -0700 (PDT)
Message-ID: <07ac3b8f-c6d0-43e4-a41d-23a6abbe296d@redhat.com>
Date: Tue, 14 Oct 2025 21:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fixes for vfio region cache
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, Thomas Huth <thuth@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-stable@nongnu.org, qemu-s390x@nongnu.org,
 Mario Casquero <mcasquer@redhat.com>
References: <20251014151227.2298892-1-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251014151227.2298892-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

+ Mario

On 10/14/25 17:12, John Levon wrote:
> 
> 
> John Levon (2):
>    vfio: rename field to "num_initial_regions"
>    vfio: only check region info cache for initial regions
> 
>   include/hw/vfio/vfio-device.h |  2 +-
>   hw/vfio-user/device.c         |  2 +-
>   hw/vfio/ccw.c                 |  4 ++--
>   hw/vfio/device.c              | 39 ++++++++++++++++++++++-------------
>   hw/vfio/iommufd.c             |  3 ++-
>   hw/vfio/pci.c                 |  4 ++--
>   6 files changed, 33 insertions(+), 21 deletions(-)
> 

That was quick ! Thanks John. I will build a version based
on upstream for internal testing.

C.


