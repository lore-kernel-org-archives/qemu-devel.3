Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06D5C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 12:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH0ag-0005J8-4L; Tue, 11 Jun 2024 08:27:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH0ae-0005IY-Mr
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sH0ac-0007zd-VZ
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 08:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718108822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gxMwk0zRP4l50IYuW3UJWbTIp4NX/H+Kx3YjZmJP1iIukP0+ZYD21FdJEZYTe4YhUCKVqn
 rVit4kkwl5EpodyKwJW/HiqgY5SDIOaxnvO8Cj+ejkdPbd4awHslFi2Fe8VDmWGkzdvNGF
 nTLhibIWNGCWsEOEu8bcZwI2pC3zDrk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-MoqrpIgIPOOy6cLKdDoL1g-1; Tue, 11 Jun 2024 08:26:58 -0400
X-MC-Unique: MoqrpIgIPOOy6cLKdDoL1g-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6def6e9ef2so323149066b.0
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 05:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718108817; x=1718713617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=OxbWJcTrqml9DnIGWSqYKgRmmkSm9DUfAGvopBkLmDoHLP5L9gI2EH/HeA+FVXLQBA
 hAe2nI2CHs/XUDfzW8/OrSJ0mS0X7VRb2bcqbZLcMNETTMcwRm+ux/JSKi8wvFFeG0pu
 AbxCUJas8zrUgITXBh33IiUBj5PCR80PmbL9+Pw72s6lpTnVUfH8livahtTWp/JPvxTN
 SAPyDYNUNc+OfJRLATomXL61tdcgTde6Z6qxmRDfinTvc1qKSLW7yw5mc2w/TukS91eK
 dzbf8ffgysDN3ZI9v5d4MtBrBZdFKBtEieNZUUfKq93sECsoAls3uvzD6HVGZ+/oIInc
 68qw==
X-Gm-Message-State: AOJu0YygX4NSOBzpnBblCmeunRHJf6gYevVsoocNUWr6Vjmz881OdZYU
 9MQKV6YQB1cIsHWUt2IbSw+xtcaR7qTkeUnWwZRN6bcosZttVsoTp8HiZv5c6MR2kduLHrx0/bG
 2JxtXdihaw9PAunQKsh7P3AAkyCIzIdBq81KzPXqqg/On33KKXqMg
X-Received: by 2002:a17:906:f752:b0:a6f:2000:9811 with SMTP id
 a640c23a62f3a-a6f34cb47b7mr156564966b.13.1718108817679; 
 Tue, 11 Jun 2024 05:26:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoJYh1X3/DdsogwmSRla2ThmVoraYWChWTfAE3abrBGPraG3Qk3SczRzLCUdlMlGydRQsDpg==
X-Received: by 2002:a17:906:f752:b0:a6f:2000:9811 with SMTP id
 a640c23a62f3a-a6f34cb47b7mr156563866b.13.1718108817285; 
 Tue, 11 Jun 2024 05:26:57 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6e89b5ee63sm567702066b.122.2024.06.11.05.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 05:26:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pankaj Gupta <pankaj.gupta@amd.com>
Cc: qemu-devel@nongnu.org, brijesh.singh@amd.com, dovmurik@linux.ibm.com,
 armbru@redhat.com, michael.roth@amd.com, pbonzini@redhat.com,
 thomas.lendacky@amd.com, peter.maydell@linaro.org
Subject: Re: [PATCH 0/3] snp: fix coverity reported issues
Date: Tue, 11 Jun 2024 14:26:56 +0200
Message-ID: <20240611122656.69171-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240607183611.1111100-1-pankaj.gupta@amd.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


