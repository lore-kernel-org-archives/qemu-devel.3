Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541B2E6400C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 19:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tED3e-0001UG-3f; Thu, 21 Nov 2024 14:41:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tED3c-0001Sx-7X
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:41:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tED3a-0006VP-N0
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 14:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732218097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ie4i9obkCVgDEhF658926iPRSRRHySc7t7PKaqEA8qmL13KvJ1V28xgS3Nu5hcfAso1Nmg
 iwY1HzfOkJQuACIcnHBA4RIrI0YvI8seqfJgX7Y1p7e3C41rMUvWZZZXraWykLI6w5AYvv
 sZPl5LG2Z50Ewxs4uIFzrwxF3CQ28sM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-wJS47L16PpiyAJdcKZ6skA-1; Thu, 21 Nov 2024 14:41:36 -0500
X-MC-Unique: wJS47L16PpiyAJdcKZ6skA-1
X-Mimecast-MFC-AGG-ID: wJS47L16PpiyAJdcKZ6skA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso11188755e9.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 11:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732218095; x=1732822895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=j9gWKAowwJqhH3RoYwx2A7c2MzBqu1kagVkE9NCD5bBMQ0w0wJzqH+TahMlwjydo5y
 J7l6QhN8adnWlWLLfQw9993NNHNIoS1IgO782+6rt0BTpZOi6F7uJT+6hHWr/W4KL4ty
 TG76433zmaYWKm/F9nG3VsVaqgfM58Cwo2rGaAQilbLbJS0DYNu38S924uBdwcGFtQYQ
 juZdE/QpAo8Twp7ObVcvKYJR61T0a5yGH5MQxxFp4MGV1Xg3QfoNGHjEFWHCCwXUK2fC
 dAmuXg7WtcA1M+WkgCcdNUzQA6Aw6ysAV6Zx0C3yt9etz6vBzebPkaMflGcsrX7eTfqB
 LQTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8ogAsQJlqkwxtXQT8oHua84PhPKP/6GCJS+EJShiFTxQKa4F6Hvv+wn5fxcNoPWw5cdn+FujG2+x/@nongnu.org
X-Gm-Message-State: AOJu0YyEaDy304jClFpikhM3K7BTMDnzUiAI63rN76IT1725+3z7rTYx
 LmlH/TXObaF/HH2MuhEoc8ZMcveogTxTbHXcpvYqozMfu8XzreLhMRVcrLhQBvejSUYLxNo4neo
 ndBnH3gtmWfJoX0gUxGo/2IGumDnMrbHdhl+G//JWSHYRCACfmeZs
X-Gm-Gg: ASbGncsvEAIVIM+MQWxQ4ErsphLBvsH+r8WZ8jnMiCZOlUtRPb9I3rSXccJeo4BgcxU
 R6ufSbxCnfL7GUJRlzsIi/bf8ohfzXJcVAy7QyG1ceMYIgebnOQ/c/t5VDJEm/jDbh0gIjCgM5x
 cv71eIsObq222xVisuFfiWExg6joHyEZF/wFnXf/mTI31hor4xg6ybcjjlSeBZbEKzHi2JUlUP+
 sXxFD9Q3C8iG05+L6HS8KE17Qukgeu7TWFcVshcG07GNuPT/tC1Qg==
X-Received: by 2002:a05:600c:310b:b0:42f:75e0:780e with SMTP id
 5b1f17b1804b1-433ce41ce59mr702915e9.10.1732218095522; 
 Thu, 21 Nov 2024 11:41:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHW9rFV8ZJPX9lUrVy8D4PA5XmnA4PAwVOZ/b0dglMu+GZB6elzme8F+1oznLoZvtF2tFuAzA==
X-Received: by 2002:a05:600c:310b:b0:42f:75e0:780e with SMTP id
 5b1f17b1804b1-433ce41ce59mr702715e9.10.1732218095219; 
 Thu, 21 Nov 2024 11:41:35 -0800 (PST)
Received: from [192.168.10.3] ([151.62.196.119])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bdba0sm65405275e9.14.2024.11.21.11.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 11:41:34 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Hannes Reinecke <hare@suse.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] scsi: megasas: Internal cdbs have 16-byte length
Date: Thu, 21 Nov 2024 20:41:33 +0100
Message-ID: <20241121194134.279855-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20230228171129.4094709-1-linux@roeck-us.net>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


