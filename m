Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5539112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0MD6-0005JD-RD; Wed, 11 Mar 2026 12:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0MD5-0005Ii-LW
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:14:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0MD3-0000C3-FM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:14:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DLSREYVOgpxQz3J4PUDfefSBeKV3Tzq7wFdSOz7O5mrWSkphGPfPjIhC1eGXgvT2lB1Y+N
 URPF2b3YGAqpaV8YvdzikGLZoV0xlCniwnyc5ZYwwz9Hl5XwEMy98PitBPC/tr70sWvRl0
 gXRlNET9DOaUxHrBPHlSJzrI2khtMPc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Popen9PDMu6QH71LlT6_AQ-1; Wed, 11 Mar 2026 12:14:54 -0400
X-MC-Unique: Popen9PDMu6QH71LlT6_AQ-1
X-Mimecast-MFC-AGG-ID: Popen9PDMu6QH71LlT6_AQ_1773245694
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-4362197d1easo28026f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245693; x=1773850493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=CmMzHwyIc/rwgBp/++cVwynrWP9CNw5yAW6L+sakCNAv2CijkjfMEoYhncdknQJfSj
 mfRZe1tAcLsGhGvKYRRzYtTfqKwd6mM8dC3aiiuEb3rBv+jMEz9dZ/rUcc3H4LadThj3
 ESwZWqvxwdiKFGsJ5SLqI43HkGaTQcEbbk8/s2oYRMeI8VP3XIJSCYmnmA5317Uhflpf
 fTAjLHfB/XwQnXWC0wc9pfeNwgDhfPmuAnyW7AgTMG6LbAqPgbgnh4wa6JZUUVvQ+1Op
 9ODFujDBU0L2BFFdpfVR1EN0Vvx6dMUYiET24wCl2AMPhP8n74+A6JFaDlc55Xmdqxcr
 3Xnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245693; x=1773850493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=AVN3pji93Hyh4X3N+mVZZihzEAAWthb8UduQYrMZ3U5k5Pu36JCc76DlETRTwevLoU
 MOSngbBTBZ9+EGd5u/uP0Kd1p/wjVx4+A3SFvhedpYd8P31Z3tZA+EE/LwVWfH5FFXTP
 59NXwBDK+u7bnGFORkdT4l9dUMsQXbCBxK4W6HmLB7khoZ0mz+rLszOltQV/u6zHFrBP
 88XIzuY5/ieCjAZ3ju88ye+XIpGyfhJ7uVE6i35S3kZRjgq1H2vV58TmV8J5u+38wzW/
 W5WMxNqKn6uxpJ/0HSR3IDhBnAMHbCKIbblfszmxMftUU1LHOM+Xtp4qXGyCzwZCDGmj
 v0Ng==
X-Gm-Message-State: AOJu0YxuDg3TXJebWulf4FFUrjv69hp/C4pNiujSVjt8Sb4VPrGJSwFN
 FA90gccBR2DS0DRY+FcgL7uT6RJig1Cr5L9fJkdo8lU5LQxj4r/etoc7iQ7FumPatsBFy+qQHUd
 HTG8Bc42OQn4PDlK1ZsnIEmGQWx7Sj1bMm49omlOfHyb7jtWr9KzjEmBU
X-Gm-Gg: ATEYQzwUacA+4/WcfjEzouuREs1yhZvZM6txntklnuYZZPt6iGGMn+JkCond2D3zPgR
 eluZQJdwU3LgKxBd88VCVi874ONHQUjle+UrLtGtivfFCknJ2PAz73Q5Q1Z9+5ELUwDzLoRA2Dh
 /meawdNawDRfK+eW+3pEmeVhKeJsuMV3VDZuLYjgzO7TKoY8sFoP31MmttqR2az4MzaWGlL7WeA
 8e1YPD3vXkVRbwu4VWIqRSnxc/ZIK99R/tu4+f5R8t7Ircpq+z8/3kTMcGJS9m4/OiyBWSHhJfb
 h5PUuNiawWzVQweuKv7ucqQwz8wW/nxAt4ljcp4ut/4GnIAF2Wc4Ew0opBJBXBfyRQIG4FjBTIn
 f19U7jZCgTz7PUr1shzFhWp91kHgFVEKQUOXB75Fj1Q9tCd8N8Rb46uV74dHChCEilqr163B7sQ
 ig36Mh5CF6reh7OP6pxkuVfnPWjfw=
X-Received: by 2002:a05:6000:24c2:b0:439:c62a:6dc2 with SMTP id
 ffacd0b85a97d-439f821deb7mr6393400f8f.41.1773245693426; 
 Wed, 11 Mar 2026 09:14:53 -0700 (PDT)
X-Received: by 2002:a05:6000:24c2:b0:439:c62a:6dc2 with SMTP id
 ffacd0b85a97d-439f821deb7mr6393347f8f.41.1773245692973; 
 Wed, 11 Mar 2026 09:14:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20c473sm188127f8f.24.2026.03.11.09.14.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:14:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, mst@redhat.com,
 marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, zhao1.liu@intel.com,
 peterx@redhat.com, farosas@suse.de, wangxinxin.wang@huawei.com
Subject: Re: [PATCH v2] target/i386: add compat for migrating error code
Date: Wed, 11 Mar 2026 17:14:50 +0100
Message-ID: <20260311161450.559081-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310154348.495332-1-f.ebner@proxmox.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


