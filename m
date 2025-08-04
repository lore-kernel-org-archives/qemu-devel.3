Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A3FC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj0Wf-00083Q-0a; Mon, 04 Aug 2025 15:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uizNP-0005vN-Fz
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uizNL-0000Bz-MB
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 13:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754330009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2J1JyXGekEZnF2fndvV/WBY/5TS58cH/Qmi/AGAC8S0=;
 b=iGH4GDbgyNhkj5iEYTSIDRtVshNk2acynVKxVC/PuvNlojZZEt6o0LY5qJrYxWiF6Bytzq
 3VOanlE86oH4xJNe1Xj1EyTzqVsNHdd8Cl+ARf62hu4+bs/lh8iF2Y6mJksXDtNbHk0P8q
 hOxfFHf31I2VaQ6tgpRBaCi1uYJCN4w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-A3YfDSFaNMKJaLLX-ojnEg-1; Mon, 04 Aug 2025 13:53:28 -0400
X-MC-Unique: A3YfDSFaNMKJaLLX-ojnEg-1
X-Mimecast-MFC-AGG-ID: A3YfDSFaNMKJaLLX-ojnEg_1754330007
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e7ffe84278so206795085a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 10:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754330007; x=1754934807;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2J1JyXGekEZnF2fndvV/WBY/5TS58cH/Qmi/AGAC8S0=;
 b=pHYFfDGesLvYWIJFnFTU+oVZlQcVjLsdQ555Goki+nZYcsKL3dne+ZEKngZajQzlT+
 cNeEviOSDLNdkbDhnAsFiqEZvCnyj2MBDfysCU0eN164Z8YRK93spuWxOec5TzlYa32x
 2qWsGldMnw28wzUAjdKctpHTVouIC5OT6toun5NsqGNvU+B8QQHmP3Dkfa4g69YJEI3O
 MLyZ/46XXAR0G4iM8rWsNIGRknNtlyMue0P0aJBfV1e5I3MQ+pPYgTjsG4wsylo602lR
 KJtpr0A6r6CcAG9fHJRO+7Wi4cDP6/yQMWhIjHlGNnBIXiaolVb+CewHP8955MzigrE7
 p55g==
X-Gm-Message-State: AOJu0Yy6uYOiavHdJuTgy8dBtcdD+N/oEPLZKsY9WjsvrYxFlEk3YVQw
 iu1ADxMciKmNkQGrGSrP/eP7stJhiprOeYsSh7Ik/rrpYvxSsTcX2PrqozgcL8WER6STg961dzA
 z9XDljopDxf1+n2oNBV2c8mOnlMi7LFVIlwH234ZG5T6WTNWv0njbSS4w
X-Gm-Gg: ASbGncttEs/w+/ZPRp3g0pzAZPiRVyQK0Zf+2bFgpCsGdzF8t0rpJjQelApXvYf38iu
 1N0yfKMAWeJDEW2mxRRS0PYPTJAvY21rYSX2Q4rOPWsFzBKW6QIgYJcGOaO3gqng2tVIyfhdtdO
 sT05R/DCJDe/x2mEQzeqnQPrd9ynJ804tpS+Nz2D680+qi+g4biQW7au2u3R9AqtSYLZswLmQD3
 2DHd7l8BeQwxOiwBFRIqCrw3aQNrVJdB5zzwNgxioh/g5gmzoUWPxPv6/UXT8WTHRKsfxWRc1hT
 aAr1Ge2bT1LQ4Ti53XcZEzb5ST2q
X-Received: by 2002:a05:620a:254b:b0:7e8:89f:9101 with SMTP id
 af79cd13be357-7e8089f9c2amr200991485a.39.1754330007391; 
 Mon, 04 Aug 2025 10:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFejt3MBpurJjDBEG5ol0FzPErW7/S0Sts02+/8T+umGpAzACXQTNqIZLo2r7rd/6owB3bM1Q==
X-Received: by 2002:a05:620a:254b:b0:7e8:89f:9101 with SMTP id
 af79cd13be357-7e8089f9c2amr200988485a.39.1754330006853; 
 Mon, 04 Aug 2025 10:53:26 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e806ad969dsm71881985a.78.2025.08.04.10.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 10:53:26 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:53:22 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH for-10.1 0/2] migration: actually make gnutls workaround
 functional
Message-ID: <d5xctfzcrtbanvkndamonxgqo3tc5nejhyrvh54m3y5bhg4cms@ue7siue2yw7o>
References: <20250801170212.54409-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801170212.54409-1-berrange@redhat.com>
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

Hi Daniel,

On 2025-08-01 18:02, Daniel P. Berrangé wrote:
> This is a followup to previously merged patches that claimed to
> workaround the gnutls bug impacting migration, but in fact were
> essentially non-functional. Juraj Marcin pointed this out, and
> this new patch tweaks the workaround to make it actually do
> something useful.
> 
> Daniel P. Berrangé (2):
>   migration: simplify error reporting after channel read
>   migration: fix workaround for gnutls thread safety
> 
>  crypto/tlssession.c   | 16 ----------------
>  migration/qemu-file.c | 22 +++++++++++++++++-----
>  2 files changed, 17 insertions(+), 21 deletions(-)
> 

thanks for finding a fix for the workaround. I have tested it and it
resolves the issue.

However, it significantly slows down migration, even with the workaround
disabled (and thus no locking). When benchmarking, I used the fixed
version of GNUTLS, VM with 20GB of RAM which were fully written to
before starting a normal migration with no workload during the
migration.

Test cases:
[1]: before this patchset
[2]: with this patchset applied and GNUTLS workaround enabled
[2]: with this patchset applied and GNUTLS workaround disabled

  | Total time | Throughput | Transfered bytes |
--+------------+------------+------------------+
1 |  31 192 ms |  5450 mpbs |   21 230 973 763 |
2 |  74 147 ms |  2291 mbps |   21 232 849 066 |
3 |  72 426 ms |  2343 mbps |   21 215 009 392 |

(data reported by query-migrate QMP command after migration completion)


Therefore, this workaround can be used in environments where we cannot
use the fixed version of GNUTLS library, but I think it would be better
use polling only if locking is actually used, so the performance with
the proper GNUTLS fix is not hindered. Maybe yielding/waiting inside
tlssession.c before actually locking?


Best regards,

Juraj Marcin


