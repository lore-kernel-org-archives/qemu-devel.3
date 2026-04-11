Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F59EF3ED4B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:28:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBXRT-0002as-2S; Sat, 11 Apr 2026 08:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wBXRR-0002ae-Qf
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 08:28:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wBXRQ-0001qJ-BI
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 08:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775910478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=VSHJWrqkfYFDcbgwUEV/4lf5drWbLpkQT+heBCIiWZMC9lzRjvomtBskbUcQJPTQkcLbU/
 DaSaOhRdm6ev5ns8dQ/4OIlIUfRm86mxouzT7fCEf+E16++SXK+WYrcDNrAefeksLHwcQm
 Pt6ddVL60tNmK17MVtOJc8FGXCqCQDI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-yYLnSnFaPNaqbArHTuo24g-1; Sat, 11 Apr 2026 08:27:56 -0400
X-MC-Unique: yYLnSnFaPNaqbArHTuo24g-1
X-Mimecast-MFC-AGG-ID: yYLnSnFaPNaqbArHTuo24g_1775910475
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488dcaf2f2fso4385095e9.0
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 05:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775910474; x=1776515274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=jzDxu8F1YUrdv48f91Qt+S7rWjWk9aQZrwLw2SHd8QuT8an3C/UY0+yfiwgNF07fq7
 74PGA0QC4QqXFY5wx6WL3AiCP2lLiJFlppjpFaOQv+Khd0T6B1Iml9cKNYT67aU3ce45
 INamDueaOq1Dr1UmgXIg7cYPsxpGLaI9ZDnS2lVmf0+9al/MJkZd2ht94d71Ohlr0+FZ
 g31XLzVJPKu80D6pz/9vzCVBuQ96mm3jmuvCHRCqdbz9tgoOj4zFPSIaJ75ZiKSMhsAO
 vgceVabsqM4QAdGbOXiYSjmUiQvUkYKFXobc+Yuj+53QRN2+8psHeNwiNJ9/AHqCpZC+
 9/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775910474; x=1776515274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=H38wEQ6xT0G1NSFekdy9L9krUfQ7Ok/mezMUZBafOL+dAlkWFndyEnoQqXyZMp8O3Z
 hsmuW948SCSB1xHqyN1wkiu7CJ+8w5seYXBIHSdXrBY0Jr6gXjSmNJccmLc3rr9aq9bz
 CcZE0YdKmoiIK5zbQ9P9jmjiGTYmnGQFh0mBAOjACKNo1BZ2pDG3900tn7GIpOZMo1+T
 /q9LhdQaqq6/7Fp7mxnj8m9Q8pB4jKLNjM/E5IbAB1zOCW9f1BniSkMBy4FbSfARh7qI
 l65nn57n9Z3NZ5eqq8Zc0CyVdthG1g9Qu32iAE0QvkwsCYYBSYr514tk8AFfvQgN+J7E
 4y6A==
X-Gm-Message-State: AOJu0Yy+9f38IBYGJg3Rt3SdWrnapeUIVGbWY69pvJCj3ZGvG0sYMUyq
 QtpWteVWiNwauND3t7wuUQwZdin86DfLKqIjI69kbLt9ArrNwaLVLHqENFpsT2FRyqJeBxv6T6E
 5QNSLzQBi2EDy2/Szj6sigaJ7sualVVfAU5dJ0113HFFZ8qlNIKWqF2wAOOLKKKQD
X-Gm-Gg: AeBDievsEuVyCEczVfSUlR+1TJKP2I6vwLCIB2Buvpd0l020v+D2m74FNXcy785FVbi
 ESHzHxDdDZ6JnUUiW/xeQ9KTHUuTYYdDsCE9pjBST18m0EMmGIingaZdl6znnoG0dm2a/nZqjkZ
 U8fChMqWzohrDQ4ycKPqTefBqu6Z0LULel0MLmnIloaTq9IYLjZRrK9mg+xXJhX76IUm9nhUA5U
 JjFEVYvmuRV5lbkJJruELEcTtEj2wwZSDZ1HVGnExsT0B+aMzqzSWp8wq4Y2OiTLOhNoAVPtwUr
 13mAJ+wD8hZLLgKle1rGfjHVzbX5kCmkLPJcz7MczDkdpTs8UH0qdG5ZQImrKovb7eEcvEp3aqh
 XmEDuL0VLecKfh47keMgF/4RR/K/dMTG2MXcEK0Ami99LnfTvsbMlOmjGFfcmJT0Xa0wT3TmB+1
 TeVGhkfoZCL9ab0cJUUCcDUNomgUxJCabemtAwHqEAf2aeJ6rY18ctPAwwJMX6Hw==
X-Received: by 2002:a05:600c:198c:b0:485:3fd1:9936 with SMTP id
 5b1f17b1804b1-488d67b8d43mr86658665e9.5.1775910474380; 
 Sat, 11 Apr 2026 05:27:54 -0700 (PDT)
X-Received: by 2002:a05:600c:198c:b0:485:3fd1:9936 with SMTP id
 5b1f17b1804b1-488d67b8d43mr86658425e9.5.1775910473929; 
 Sat, 11 Apr 2026 05:27:53 -0700 (PDT)
Received: from [10.251.239.123] (93-38-178-167.ip71.fastwebnet.it.
 [93.38.178.167]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d53807d7sm229735965e9.10.2026.04.11.05.27.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:27:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Aastha Rawat <aastharawat@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH 0/2] Fix issues in accel/mshv ioeventfd handling
Date: Sat, 11 Apr 2026 14:27:48 +0200
Message-ID: <20260411122748.88353-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409-fix._5Fioevent-v1-0-053b810ae6fb@linux.microsoft.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Queued, thanks.

Paolo


