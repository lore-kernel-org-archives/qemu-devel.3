Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2218EC88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pmQ-00067U-2m; Wed, 16 Sep 2026 09:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pmO-00067B-GE
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pmM-0004tt-Jh
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:34:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789565665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=G3+mxM8TH9Txt7qSdvwvARxGHokQweS3u7smgXnh6eGFwJ2mETdcc7TldAcHTcV7crWCzu
 8L3cJTx545LUpIm8mHaEix4u4qPfcA48Gf5m7+U8644NBacypDI3wo7WOFO7UWuJA/zVmO
 mR3hj0jTZiRj78x2WGjlcFTRXV4MHLg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-y8wiDiZqO_6PaPuKNqQTVQ-1; Wed, 16 Sep 2026 09:34:24 -0400
X-MC-Unique: y8wiDiZqO_6PaPuKNqQTVQ-1
X-Mimecast-MFC-AGG-ID: y8wiDiZqO_6PaPuKNqQTVQ_1789565663
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49cf9df1eadso55448155e9.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789565663; x=1790170463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eRVUx7mJ9+qPcuGMT1x9naOEpTx7qbbQ2WmD00VDDr3YmFUAU+dyPHyQ2F97DcPLJJ
 l+oMm1SKVRhM9GR3GnhefTiFbESmmVvnNsZQpmUOzNNW8JgMhQBiONSYye8so7uVwp4c
 vM0DLA1JkZxQngNubSC/uCo9aplJSk88xuBzrvonTPbrUea82AfkM74of8a7aDjGVLIl
 XY+Bu7ysbLvoiqVLFMCIl1ltNxzGRyJ4n/Qkrg2BpHwjItk0Z47Th9kkuJ3UnEtIjYxF
 3zvAZstYD94oEYoqI0WD5m9C5UgEvh4StvBFiXPRZ+gCka3zp6HfxC6d1RAnYXNI4s9S
 PXbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565663; x=1790170463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=m7Wi3g+Osx+wghLeDfB6aU9O3JWP6a7lqu5psI3oWcuH1RoIfvlykGC2KRIRTHQGVl
 +Elw+niSrTM/by9Yu89zCLTk1neYaE8OPEfCFiVIYekvjtmBo99RGD2v334Vs0deU7Sc
 TTo0G8absLhRsiFJ4G9sI+qJRsErcJA76+dGmi39NDlBIraxD/W61063roYveoVAtYLy
 u/2KLq1Jb/osauAPtsQIw4K2mcXJcR2RmD/5BtayBSPXSqfhapqVFZT/UtNMUUjfb530
 jmYBm9CB3XaCk4y7kRgGwAIVmnPmz7wHY/2inhWwehbYSACuIy3NWBHWnMIPjoLijVZk
 IS/g==
X-Gm-Message-State: AFuF++nB1iqzbNeduhinDMiyAgDta8j0VdbkUaukGBxV+dl3gFPMQqsS
 SS+eoBU8fl3FOo0UMWoBWXCDS5fv9tgXJY88CjS/i5F4xCgETjjz3vKXSDc0G9G9hGcN+LvnkWj
 F6PfUfD1rXNHafU4Ffq9TFtwHa/gSq9uTo+hm8m4Bx0/GNsI2rLO/AtXS
X-Gm-Gg: AYBFou1ttThfYx4iU/6A51gSLk0RrCYl7wrisZXQqQ1zkulhMB2PgJ1k8ooA8/jcJl0
 ynzq3EC2jqvv73Bm8NMvfzTavGqI2u8KkyDulUZxUQlLPLG+5Y0poWYMGrSgXTnGu8DWjpAteqc
 MsUKL2G+41+3ybVEvtJHAGEQJHHYC7+37A4Px2VbdEDReYqbNYIXeQD9TlQuNx9MiiCRYb6cqPB
 AzWvsX++Q8r+hb5s2kDarxVzwM1C6/xnpamNgPi1A5gZBct6QFvjBTnrAzF4Z81FKbaAhdnczjc
 5YO8LGSXJEB13U0teHkCmOeADrzOOzIpYp8kLzSJm3jQcWQ7LvVluYNB/Z+Z4eICSHV7/XKszg6
 zwomneeZsaVZM4OwRvadYBsQiYGNaO3ocK+nDc4uxJxrTQq9ZYzW5MjF+6o+adWtWtvdre5oC70
 dQs2XO
X-Received: by 2002:a05:600c:3b9c:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49eb732e48cmr41510855e9.17.1789565663232; 
 Wed, 16 Sep 2026 06:34:23 -0700 (PDT)
X-Received: by 2002:a05:600c:3b9c:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49eb732e48cmr41510535e9.17.1789565662802; 
 Wed, 16 Sep 2026 06:34:22 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf3494dsm6956725f8f.28.2026.09.16.06.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:34:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Artemii Mashanov <ralerrdirsardx@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH] target/i386: fix EFLAGS reads in TCG plugin callbacks
Date: Wed, 16 Sep 2026 15:34:04 +0200
Message-ID: <20260916133404.881716-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913173801.96942-1-ralerrdirsardx@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


