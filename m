Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E9EE4987
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 10:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soKIQ-0001ir-1s; Wed, 11 Sep 2024 06:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1soKIN-0001hV-LV
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1soKIJ-0000WY-Rr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 06:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726049390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xgZVT0ZkgzdM6nBUTpNlOt99THUTkLHGERGSpb9utQQ=;
 b=DuyIBLKXIHrKEGmVn9MAqw/7iYI/LMUC52MWpK7GNkbUTxVckFi5CHyRfq0rDHCIJuXdjQ
 yZmrlSkG5Kz6FrJTtOcsvzxlTEH5zBnoSGkIdwJ+Hd4yYnIPgPemsuuad6Lnc76oWvhnsv
 F29n9fJGnuN7pFONhJp99ERhUiNBTY8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-Gu5vFKsPNhCt7mHoj2S6iw-1; Wed, 11 Sep 2024 06:09:49 -0400
X-MC-Unique: Gu5vFKsPNhCt7mHoj2S6iw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3771b6da3ceso3401392f8f.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 03:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726049388; x=1726654188;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xgZVT0ZkgzdM6nBUTpNlOt99THUTkLHGERGSpb9utQQ=;
 b=G7DI4+kEaRAZqgRxfvD95rV7AD7UgWlYvxhEvbF0Z/5lju/dfJBW/wKPa45Df2uN3/
 EHeWsK9jN6mKfLJYnylx7Zq+qdHxLyHmFaEF//gHqhOA4jHFgM1jBJkv4KiivCJMQ8Vs
 knu4p3M3BfkgrbGFOozYgaZf/Jx4/2NoLIK7mdnjydPrUPy345O4bQPYtkXznkrVFjJq
 h7NHibWvviK3cj4JFh3AbZBVWtgNpgSRW5hXizrr2qFLd2m2+dJa5DbJt9TO/FTHbKyF
 K+kKUI4sVHH0DcdfdBfEnKTF8kjpPqgRTwrJpH8P3xHQgGq/bxPfGISMRoJ73CbGt8pd
 m+eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdfKGuDT0rR04xkdefETXSc/AdTi2bOpR3+sJvOmfSgqlVFyNJVXmNW4cRt4DDRJ5F2Gg7xVoOLd1A@nongnu.org
X-Gm-Message-State: AOJu0YyM0rqyd2lIVrED3VAedipN/+coKKfbu1CzFUO6foLFzyjzp+h1
 O/43L70YemGw3hdvuI79FSuN5NuD0oIzlP75ksFjLzE1qH6Kuf+NxME8XmLaKuEt+EXUSfZ8gFi
 iMpX3J6bwyx+9gM3IJJzhuVXUtln4J+jwmQ8fShnryCfMjQPnNHfb
X-Received: by 2002:a5d:4584:0:b0:374:c95e:1636 with SMTP id
 ffacd0b85a97d-378949f7c06mr8565212f8f.21.1726049388434; 
 Wed, 11 Sep 2024 03:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrt7vwwaT+KDH0F2vNn2mJTQOiBFG5z7yCeYwo9iLWfi1dDwGm0E1k9a6VhSzXxTtrm/m+bQ==
X-Received: by 2002:a5d:4584:0:b0:374:c95e:1636 with SMTP id
 ffacd0b85a97d-378949f7c06mr8565184f8f.21.1726049387939; 
 Wed, 11 Sep 2024 03:09:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-378956dbf58sm11111440f8f.94.2024.09.11.03.09.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 03:09:47 -0700 (PDT)
Message-ID: <8c035207-f1ee-4e04-be8f-5f1681de10b6@redhat.com>
Date: Wed, 11 Sep 2024 12:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
 <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
 <4adc32d0-02c1-4375-8618-2692a9b1da76@redhat.com>
 <20240910093440-mutt-send-email-mst@kernel.org>
 <6aeaa38c-22b9-4598-b07e-7adaee187562@redhat.com>
 <20240910112723-mutt-send-email-mst@kernel.org>
 <3f0e049e-8030-4901-98ea-be17369db59a@daynix.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <3f0e049e-8030-4901-98ea-be17369db59a@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>> Better to fix than to guess if there are users, I think.
> 
> Yes, but it will require some knowledge of s390x, which I cannot provide.
> 
> Commit 57da367b9ec4 ("s390x/pci: forbid multifunction pci device") says having a multifunction device will make the guest spin forever. That is not what Cédric observed with igb so it may no longer be relevant, but I cannot be sure that the problem is resolved without understanding how multifunction devices are supposed to work with s390x.
> 
> Ideally someone with s390x expertise should check relevant hardware documentation and confirm QEMU properly implements mutlifunction devices. 

I just cc'ed the s390x PCI maintainers on patch 4. Let's see.

Thanks,

C.


