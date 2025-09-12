Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83D16CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 12:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux2XI-0001tz-6G; Fri, 12 Sep 2025 08:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ux2XB-0001rv-Pe
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 08:05:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1ux2X4-0005iA-0b
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 08:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757678727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PLnsfHlQK/gfSTOkDSxixCUnwP0aO1C4xSYupQbpE1k=;
 b=URbLV2HUmQH2nl9OE1PhddC2k4s/VwjiviNBN62/QpoAxPjrYjsekrzfi+s8tI5iqeawwO
 qfILGJaQZ23iukTmhVbHkr/nupi6QPVujWIP+vqvjs5jIkxdCija91iXZel1hdlJYH4+Rt
 07G08DtQGFxgWJ+yj/Wa0kQVncmephs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-qrAZmxsKPvirzVA8UyNd0w-1; Fri, 12 Sep 2025 08:05:26 -0400
X-MC-Unique: qrAZmxsKPvirzVA8UyNd0w-1
X-Mimecast-MFC-AGG-ID: qrAZmxsKPvirzVA8UyNd0w_1757678725
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45cb5dbda9cso11434355e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 05:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757678724; x=1758283524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PLnsfHlQK/gfSTOkDSxixCUnwP0aO1C4xSYupQbpE1k=;
 b=Qv0vnccQnEwz3nJy8Mf7mpGwx98AJy29JqeC56xxK6xmF1SILBIgNZOXIl+eL0u3wb
 wZx0jq3RYEd5U+Me+cdq+Ai3vpbjR3dkNmooqMfhFdLvE3srZ52BdFXLpJW5Y8eKQexw
 gwpr44nh4QII4IZa+8p+Kn151WhrqOfSNwfO5ia6bSgaG+2FgKYqSleL5H97nlkssQkF
 FjG/7+aI/uQe7yEM0fl/sWQ+px4E09LIU4eqMN5LTpz0qyyo8FtNMoYGjh0m6DjbFFCm
 sqXEEVRVqS5edlvQUw+BGKyRtj88BP1lrBjUJnFb/nlOZhBmSki6uFoFrnQYZj+UFvR6
 NYhw==
X-Gm-Message-State: AOJu0Yz8W5sYAXVyGXSyIYDobceyt1c09yAduuw4NiLlBAJCwAurTHSY
 8vQ+aZLu6HZnKhQ+Ca7sNPlIvVkNOhMR6HWRCvFRhl7/hQagJhmY7Gskj292HxLUFYKRIAoMh1b
 5MAc0aAYgIdcj0om0dHIuY3RQ+R7XV7zsJiBEGoZ281M+ByAVQBi+9Pog
X-Gm-Gg: ASbGncv53F1qNujA+cbkJQLqDrVop1AeBCMtGU33klflk+ogrzX9lKuHJQ39LM+bC4e
 k4PUZPI8MmmYKEYep2pPmZGN48JIiQJ3u5tBqqUblGZbfzVcrElS+h1Z3I6hsTEjloH+Qx/5pwy
 b5KtlhEYaIgBM3PmE2hLFTycejjAUd3XVa55n1sFHT64MhV5oZ44chPGiz3dIXSdOI10NOeXzpY
 6/ia6KqyDIbyxx7dyRNCLthGQZtJMG0j8p+EbRac987jC9tCRhjMQ0VaQsnMrA5Qezl2fGHNRXp
 1Y+Lcxb36vYNly3xilS+AH9YFDr42A==
X-Received: by 2002:a05:600c:c8d:b0:45d:f7e4:87a3 with SMTP id
 5b1f17b1804b1-45f214ac212mr18922255e9.3.1757678723993; 
 Fri, 12 Sep 2025 05:05:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLKw1jvu0X7y3D6M60WwcjeRNgFp3XRZzVX8G8td/KpGOVR2Oq9A8V6cOD7dW1k9Oi7r3SbA==
X-Received: by 2002:a05:600c:c8d:b0:45d:f7e4:87a3 with SMTP id
 5b1f17b1804b1-45f214ac212mr18921885e9.3.1757678723466; 
 Fri, 12 Sep 2025 05:05:23 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0372b983sm59841245e9.9.2025.09.12.05.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 05:05:22 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:05:20 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/3] io/crypto: Move tls premature termination
 handling into QIO layer
Message-ID: <wo2345si2uwary55wxiyfgoxypwgrdvtfrobjinzl6zru2ohva@nibzjvvmwcku>
References: <20250911212355.1943494-1-peterx@redhat.com>
 <20250911212355.1943494-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911212355.1943494-2-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2025-09-11 17:23, Peter Xu wrote:
> QCryptoTLSSession allows TLS premature termination in two cases, one of the
> case is when the channel shutdown() is invoked on READ side.
> 
> It's possible the shutdown() happened after the read thread blocked at
> gnutls_record_recv().  In this case, we should allow the premature
> termination to happen.
> 
> The problem is by the time qcrypto_tls_session_read() was invoked,
> tioc->shutdown may not have been set, so this may instead be treated as an
> error if there is concurrent shutdown() calls.
> 
> To allow the flag to reflect the latest status of tioc->shutdown, move the
> check upper into the QIOChannel level, so as to read the flag only after
> QEMU gets an GNUTLS_E_PREMATURE_TERMINATION.
> 
> When at it, introduce qio_channel_tls_allow_premature_termination() helper
> to make the condition checks easier to read.
> 
> This patch will fix a qemu qtest warning when running the preempt tls test,
> reporting premature termination:
> 
> QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test --full -r /x86_64/migration/postcopy/preempt/tls/psk
> ...
> qemu-kvm: Cannot read from TLS channel: The TLS connection was non-properly terminated.
> ...
> 
> In this specific case, the error was set by postcopy_preempt_thread, which
> normally will be concurrently shutdown()ed by the main thread.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/crypto/tlssession.h |  7 +------
>  crypto/tlssession.c         |  7 ++-----
>  io/channel-tls.c            | 21 +++++++++++++++++++--
>  3 files changed, 22 insertions(+), 13 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


