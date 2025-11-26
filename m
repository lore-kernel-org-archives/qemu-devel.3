Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDACD10F5D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHTN-0003bb-P0; Wed, 26 Nov 2025 10:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOHTA-0003NI-Jm
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:30:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOHT9-0001fu-10
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764171010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKEQaK1u3u25U10idGtC5pOFpjGJv47xe80ze/fml+g=;
 b=MOA6hRCTvPaJGapEj24kydsmvP8VCeh5op//kEUxZUr7Uzr88VqSulXv7EkSUVvHEcUjxy
 PncAvAtZTHyFWa2yi8/C2WVLj4YhAdaunfZfNzL2g05SD+5mEanW4Gw/HPj7toKZMAB5Fz
 Wu32KCz10g93oYf50ZZTN6hDBTYi/1A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219--cqsfTlWNYOXNPjASC8HIw-1; Wed, 26 Nov 2025 10:30:06 -0500
X-MC-Unique: -cqsfTlWNYOXNPjASC8HIw-1
X-Mimecast-MFC-AGG-ID: -cqsfTlWNYOXNPjASC8HIw_1764171005
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477c49f273fso56623115e9.3
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 07:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764171005; x=1764775805; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=tKEQaK1u3u25U10idGtC5pOFpjGJv47xe80ze/fml+g=;
 b=YXakDdAuFD5vX8Dns72UdjGlqNFNNr5W52WZvYXXKfsHECEiJqiy7b8F/hhVXBkHT4
 Bb0qxS0o/4LZ1QL5eFaGv9DlQD+p06uE7Qw3tEAn/dmy39LQ5trFesjndu6M6MUmUWGj
 ft8RL7No6BBlvASEcr5YcJW/hpI7VPFeJgTHTmjouLA1QKxkch6hnSIP8zMZZ9JHBYRb
 ujIp5IhXKFxXkU/qyxrvGvmuOVxEsNdcLkVcHtMLs/nAYwPSCOQ1yuriewgWmc1nOfwn
 zNNQr6NbENGqjxQRGW50Yjm2+GtSSPBjw21JlUjyGM1zSLlWwvPJDfegM3Xyz24LTBPr
 5zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764171005; x=1764775805;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tKEQaK1u3u25U10idGtC5pOFpjGJv47xe80ze/fml+g=;
 b=qyyJfqXt8GXwB97pszJXR8eSGiX2anN0LdXcN1SlMdEjezzLvZ90YLvqN1rMvfCuVo
 6Q1ixeIgrAgQk0Mwly6yijaZBwp+nRmzBM/bskrH1IPXVBvJSa2eKZOe9rdTZxkRLkxH
 g8ibR8k5DkN5NSK7JyanDd5T6fDsHHt0uTTuHqv0poUeUbDwIzX5hvmndMTycHPklilC
 M7/ZBJGABecAOJAZU9M15BUvJIsWCT3rF0riDM8gREmToyz5qBCqA7NuE145NyDK0tkZ
 R1z4yHNLKBZ3kx4piaaVhlj6xIG2UPZ0rp44xNeJHLxRGpU+vshahNu0EJoJe3n9P577
 60uA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfmqlexiWHrj1qvr3+EwvBtNPiyUDbtQlWWJU7abzujgYDCNIvPqc0MUauP1Od7Ptvx7jQpzKKjnhA@nongnu.org
X-Gm-Message-State: AOJu0YxS1/Z1GOVpQkbKWXHv2zs6drQZ1fkeH8A6sus6OWsDB8p4zW2o
 7jrDQ1H7SUEt6uhfCgJVVE2j3n2+eTo/9deLhb2C0RrW9bvnHtA8oBsn5DhV9QO21dm2twGX0mN
 Zq5wnMn9309pEX/5ED3JjOsWt3VfqlxLTFeAckVEV4ySKC42lfqxkE+8g
X-Gm-Gg: ASbGncvFsobdFJvw0xyC1LjiB1Bco4v329mclZ7MkD33ho26c6G7cvkjvqPyn23Qoit
 rh0ykqSvNx0e63lrw2Nfl+F8YHtM7Rgl44Y1ka0lPHlEBK0o/sZOdWHooHhieM7n2djGECi6y3b
 5bY+MJoo3+dz/NmiLN3+cbzco5ZTI86RZsmvJ74F7oOLHbAqUjQyV6ufnn4Ql2f89FR7lZqixQZ
 5JwSfD+Ki/90jz85QD0hegk12HFExMelQPDmLdGqtJQoqZt4T2z6n7n9N97LthFjgbAc4M2nhVm
 ak9ESRbnXjC00uQguBMExuZ8OHpktJnJ8jBjcdjs839VLxejmp1D7/Io2OgFXDnGDvJepQp6rzq
 vB6lQid1zJ7siFLbAGDpsnyfQtwNxZ1z+xELVIN2Kx4GehMgZZKD/3D1LGw==
X-Received: by 2002:a05:600c:4e8e:b0:477:5aaa:57a3 with SMTP id
 5b1f17b1804b1-477c017512dmr188762875e9.2.1764171005449; 
 Wed, 26 Nov 2025 07:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG7fcDLntXJMnQwckJE3QHcqUII0nGGoPSAPstZVkqJ5gKK0tH2GR7ED0RZBeCksxhukNV89Q==
X-Received: by 2002:a05:600c:4e8e:b0:477:5aaa:57a3 with SMTP id
 5b1f17b1804b1-477c017512dmr188762655e9.2.1764171005057; 
 Wed, 26 Nov 2025 07:30:05 -0800 (PST)
Received: from rh (p200300f6af35a800883b071bf1f3e4b6.dip0.t-ipconnect.de.
 [2003:f6:af35:a800:883b:71b:f1f3:e4b6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adf0a27sm48584475e9.10.2025.11.26.07.30.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 07:30:04 -0800 (PST)
Date: Wed, 26 Nov 2025 16:30:03 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org, 
 oliver.upton@linux.dev, gshan@redhat.com, ddutile@redhat.com, 
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 01/11] hw/arm/virt: Rename arm_virtio_compat into
 arm_virt_compat_defaults
In-Reply-To: <20251125100859.506228-2-eric.auger@redhat.com>
Message-ID: <7bf5729c-ef5b-8925-cbf8-85f21f9cc5ec@redhat.com>
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, 25 Nov 2025, Eric Auger wrote:
> Renaming arm_virtio_compat into arm_virt_compat_defaults
> makes more obvious that those compats apply to all machine
> types by default, if not overriden for specific ones. This also
> matches the terminology used for pc-q35.
>

s/virtio/virt/


