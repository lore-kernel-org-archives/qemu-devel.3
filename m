Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E4BCD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 16:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY4Zv-0001rH-Kt; Fri, 12 Jun 2026 12:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4Zt-0001qe-KC
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:17:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wY4Zs-0001zQ-0t
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 12:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781281071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Idq3/53DiGnRE6P+qYJzic48F217iWQA++IUAzNbg8o=;
 b=LUGXYtXhcjg3nh9eeu/+5HVncKhtkWdmTzK09ONDuvLLF4vxDgTPmyxcfIonPYFUy2FLmu
 JPcKbRF3Aisw0hOoBTkR3iUlL00eD9NX3qvuL34yvqtDwHA+KKtMxqvCmjgaJSC+/aNqMr
 rdC86uoJWniWaPzQDPm2rmcATLSvD6E=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-i5V6wZguN8io3cmpVFF_nA-1; Fri, 12 Jun 2026 12:17:50 -0400
X-MC-Unique: i5V6wZguN8io3cmpVFF_nA-1
X-Mimecast-MFC-AGG-ID: i5V6wZguN8io3cmpVFF_nA_1781281070
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915757be497so156935285a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781281070; x=1781885870; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Idq3/53DiGnRE6P+qYJzic48F217iWQA++IUAzNbg8o=;
 b=eGq7k0rUwapqhBpxXcqXm0+Kr5oIah+YUS2SPidp5pngO5zNTy96tQZos3dt+ogITi
 3WUzmEx5g298dtycf2iF37popgybgOgk5xTq7BB1tj5KMuxFxqCVADvo+rMllVKZ4Fp/
 xDxBdKRdMvmfTaZqUq82jix0QQCJ29ddoEj+wPFpr/DwutEMgvXuvkdFnz8odfl5HL+T
 qbA5n2jO2tjKgODRFcgMefahDOqLVVvs0fMMKK1awbqzoVQ6dFuvdDQkVVKZNUFZlQsk
 +rYD2dgTSpMS1CdRnxErHENX4sUFEoxFxlEd7CMEmMACoxzbfEFlNzzTwLqo4FlgazfR
 JTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781281070; x=1781885870;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Idq3/53DiGnRE6P+qYJzic48F217iWQA++IUAzNbg8o=;
 b=WOPotm6ASVSkwFP9nvB1ehld5iT6iFfcMIBER/aMpVSOGVNGs5SCsQJd/IZl1y3bDW
 8wP7VF1M3KO2USW/qfADvH1FyFEKhk+5RK/96KggtcYV6tISkkZ7UCxWOkV0jSI62ajI
 IIHxqhC42Ws6FlAcvvttCDbIaA0M/bn6vI8PtYpdD39K9AQ/wvefYZO+cQ0dULftjCG0
 YO3iBdF11CEDa8IvXTyCRFDSPgpHp3DzuEAzYoIwmiTTWaYjt+OU4oQYtqLIsa9IQ4Sb
 dFy9g/YI0l4LL7Ca8i+oxnv+0FVVEKkKUL35JD5pGLV+phk3B9cWdk6QE3HS/yrhlSJ4
 1xXg==
X-Gm-Message-State: AOJu0YwtoiHScjASpfdVH2Z8Tnk9Ur9oQ6vACERcroc9Qmh8j+rJXaYe
 GOaCYqyNyjROouRiJ6yLFLo2SFbm01409NYNTN9AKwlRxn9JdFlC+480pCrOhvKwN4+Ozxn9cVx
 Jc5WZVb6SjVCmlRdDkxCkJBWAs2fJJ4wR3Rfqh3ZBaIaAvK4erJgvzj1O
X-Gm-Gg: Acq92OHiQRQZif2J8iOjYAsWxDXNRCEHu5vHdnJ99X9/AbamPeH1ZA1N6NV2TApnNrG
 FL563++FErbAe+zqF3j0/PmX6R1PDfBztBW8hS92KFIcK9EEHWD8PtF8hAu1/lOiStDjGdffwlg
 eC3hzfeDZ0ccgaCaSTyms628S3zPbXnEcet5WbJfh3RxRYGLOWs3AtBLpyVMhYelOBoyMbhqdM+
 p0o1n0dJtbsY1gbQ2QG2QcCRXc0qW0qkynW1FIZpST3hf5bUuqTSSYlzXBOGqwg0n94LufjtNFL
 /EL0FYNglYV3gkmZmXsVUkG2UMY1wTm74cVuUSK/KdvKUzRjLgK14gYlZhSYEoV34vqedj57Pob
 0tW0IzY+Uf1jFDc8=
X-Received: by 2002:a05:620a:2948:b0:915:b9f6:718c with SMTP id
 af79cd13be357-9161bd3b1abmr453361885a.28.1781281069556; 
 Fri, 12 Jun 2026 09:17:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2948:b0:915:b9f6:718c with SMTP id
 af79cd13be357-9161bd3b1abmr453353785a.28.1781281069052; 
 Fri, 12 Jun 2026 09:17:49 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9161a0541d3sm246871185a.39.2026.06.12.09.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:17:48 -0700 (PDT)
Date: Fri, 12 Jun 2026 12:17:45 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v3 08/14] migration: Fail migration if switchover-ack is
 requested after switchover decision
Message-ID: <aiwxKUF9uKAgYuK7@x1.local>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-9-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260609075812.32067-9-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Tue, Jun 09, 2026 at 10:58:06AM +0300, Avihai Horon wrote:
> Switchover ACK is checked only during precopy while the guest is still
> running. The last migration_can_switchover() decision and guest stop are
> not atomic, so a device may want to request another switchover ACK in
> the gap after switchover decision has been made but before the guest is
> stopped. Migration would then miss that request, which can increase
> downtime.
> 
> Cover this case by failing the migration if a switchover-ack was
> requested during that time.
> 
> Ideally, precopy iterations should be resumed in this case, however,
> VFIO doesn't support going back to precopy after being stopped, so
> implementing such logic would require non-trivial changes to the guest
> start/stop flow. Given the above and that this case should be rare,
> failing the migration seems reasonable.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


