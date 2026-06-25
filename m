Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC66CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:07:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrHv-0000ac-OE; Thu, 25 Jun 2026 17:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcrHt-0000aL-Qn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:07:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcrHs-00008k-E9
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782421622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=OPxemBMTDKHjm3DeGfEQrNKNc1j66Q/JpGMr+YshfAidbC5+cjoKJ0KO804Ah2CQKpzrA2
 DkXCw7XHmqxXYNG5m5GBYZJ1YkzrZ6Us5y8sbJwXxeD0Jf8UCZibMHZQsyB+0rasAEaoti
 doKZrFaQKfoziZNCttOrzuZPZQmo6TU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-FE6tj9KJM8OPUR715X4QKw-1; Thu, 25 Jun 2026 17:07:01 -0400
X-MC-Unique: FE6tj9KJM8OPUR715X4QKw-1
X-Mimecast-MFC-AGG-ID: FE6tj9KJM8OPUR715X4QKw_1782421620
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b0682d2fso2196515e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782421620; x=1783026420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dgIUBqLf43F/rSOxHV5ZfLJeDuWPG4ymPc1e3FB9Nn/51H/ytOe+MhLrLBAXcxX5+p
 fpFaSZwoqHgjrS+Hf/Vh0y2gJILl4VjW6iRVNl12JupgjvOJUyJPaw/3qn8Cg294Utha
 fnvduEN9EuRPoLhN/+kIbWC0GS/uwwEPYZKD+h4mjpg2VcHvQPMMz98+Muo+1ZFs45lN
 KmYdLlKYGfCfO83Z71zfZQhqflt+qUEXj3e/7wXVpUQuGS40UrHAaxI4qg+Qpvs+ps6J
 O2b34EhJGLp1nWpkGEtan0nUvpbfGaHUmUTGRQ0Q0T8XigGd+/X3lHK5fmDW316zWUfI
 LfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782421620; x=1783026420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=gKJiV26Q3yQ/Zx2U4lIqyCrorg+PBinvXaTOtz6Hg9ReUFYo2YcEe0T1q0wrDkPVOy
 ivZxUnv4Ua1oa6hcENFnDqn3Ehyri2XNqqKmIY17l/5wykjp0wIvtvcXG75bnRvkxqHG
 Aong+jav//oi+WrOU391xUFnRQBcDmD4vUSZBCDpf/SAA2/Iz6QIYMwEd0ku6risikRH
 uEyqGvIqfSEwD9JRlPjseBjK2TMYerAtIkcoDtHdxUVMNY6h6srzOGknjzVt1w9yaSk1
 hVX03Cl15UPRvGv/qI1ZeTckF52EvMmedZclUBXX2ontVBPqwe82DrZ6vBkVLvhcUqsq
 hmlA==
X-Gm-Message-State: AOJu0YwqAoIFiS1ysXyY4a5Jv39Sx1JlUbH3uBSFwmNUcMSE2nmC1kwl
 eQMoo9+JO9ofhEN015MCd5kTYixHr26w7zJasNp6vMV/SAEb0/1YrK1liXi5jTv4uxuLC8a0+Un
 6qTFeOmRVw95aWQha9X6x7m4BpAxo1qL+6cWlDNqrZ8SPFxY86ybUEvA5
X-Gm-Gg: AfdE7ckLZYc1scA+kCU5/8/me4sgnnkvMWKNY106+4hFNtYqaESBsOsUeUXuQmN1JMi
 Is3k05hRh0FcaEBp+lQD2juVQykhCS+iHuVQATZhsMEZVQfI0qp41aQg3mQmMG77PAsTyN1G8Ic
 i2aCYADGgnTCGOODhHaf7msdinFy+xUXKIiXuze0j3ctqeDtkSYDOh8jAJ1gmBbrPyKdzmiS/OV
 6JIT+KWb3LDoCbRjSyirWuiZqnJSNje5wHgjEqA9M+g/tcMRRrEBmow3v+PUM0+y3hdpM9AnAIj
 8M9IFm7you/iB7YSv57xwNY4U47yS1XuwVL3Z9VfUyoDJNs3xk2MGKbJGWxLlOpqvaFdOvBb/+W
 itVlR6xD9rHzvv6BVWbYnEJZDBaEXEYDIDqhKWVcwkXtpS6Bj3sX+D3pnUj6TNBeEg7PkFUt4wp
 isnoLcAyCtKAiWdX5j
X-Received: by 2002:a05:600c:638d:b0:492:3763:aeb9 with SMTP id
 5b1f17b1804b1-4926687e72cmr56638695e9.21.1782421620129; 
 Thu, 25 Jun 2026 14:07:00 -0700 (PDT)
X-Received: by 2002:a05:600c:638d:b0:492:3763:aeb9 with SMTP id
 5b1f17b1804b1-4926687e72cmr56638395e9.21.1782421619763; 
 Thu, 25 Jun 2026 14:06:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fc0f32sm25291215e9.3.2026.06.25.14.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 14:06:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/6] target/i386/mshv: use hv_vp_register_page for fast
 register access
Date: Thu, 25 Jun 2026 23:01:11 +0200
Message-ID: <20260625210111.1679240-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

Queued, thanks.

Paolo


