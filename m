Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85E64CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 17:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5691-0001m3-CH; Sat, 04 Oct 2025 13:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v568v-0001lp-VX
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:34:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v568s-000640-Qq
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 13:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759599235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q+Rpf7RmauYFmA6SJGqwwEzXZ2IXqlNAmSuh9e7eaY4=;
 b=UB8unU8MApV3HmTlxUt3uxlqOf+Zkjtn+6sbWMGD6eUvMbJn5KhaaUGeZF6fiw7kFk00Go
 OJJUkgnf75Tifiw71EChGPmLkGpAaVP3WUhevIMGe0wVrvAOLOho0k9z9jUCM0JVUjSGHv
 RmaJXKujj8YWVIRKbJQChTx1Q1nFOvs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-0ed6RQsRPUunActR4UsobQ-1; Sat, 04 Oct 2025 13:33:53 -0400
X-MC-Unique: 0ed6RQsRPUunActR4UsobQ-1
X-Mimecast-MFC-AGG-ID: 0ed6RQsRPUunActR4UsobQ_1759599232
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e4fa584e7so14262605e9.0
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 10:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759599232; x=1760204032;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+Rpf7RmauYFmA6SJGqwwEzXZ2IXqlNAmSuh9e7eaY4=;
 b=PYfBe7dvoVLWDky4KBtk3/B1AFqgNDrk04De1EyanYj0rfpt7IBUxmee9jScUw99rA
 ftAL3mYe5WxlfJ1vSKoWZVgxDjfUd3BXsNtdo5YKP9RlO2N4PW14CwcyidcTOLTOKX6r
 K96vcU5tes1Ued5FM4tyVB7uqfCjdUyRFPsJNSnqCMGXbb5JpFYClUoAOWRiOYkfxKc4
 uCebhuWqE23ON6vmavASxokejZg1T6tq3wLbIfS9OZnpQ/dxed7GA/0lUTSs2t2uR8DK
 FSCF4YeWNdSfGkjGignbhG8LNauUXMUqJjkiQe3AhCdPMotqgOpkUe/RdRve9ZekPve0
 sIKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWy4+7PUFYqFaRWO/E5XzJ06uzbbG8gnUwBekcw4pAstLS4EHPcTCnmUauxTEPNq9FP6KZVg6FYMNU@nongnu.org
X-Gm-Message-State: AOJu0Yydn4mh8idcBezRxPGL/rmJfaux6IdCy6HCRVbDNAtGxoChmtph
 md9zu6lBLH6fflwoexX954iIoGCSkd+jJv1CXQUY5gLo5HEt2tQmNbMwlyeh0Lh8c97K5BJOPU1
 lA5Mx2qfA7LFWhE4Qlp3P+aTOVAk7YiOFMYuTicTg+eEev71Ati/Yh9/a
X-Gm-Gg: ASbGncs/cLhmYVd1v8vnlX6RyWwun7FARrYqxFaPgLfZgkVPfIg+9OFkE0SlF7IJP9+
 GSFlRya2NLWVXHb3hJzkkcDiop1VO8AIzwem60QjDe/XCWzwIDj/s4VXxgsmhC+ilY4jtH9RIY7
 ZJWsm00FH4/5hl3Ej3rx07ePG4IrvyeC7gqUUTrvzG04lqwkP3FDIErYOINVOuiIPBf74r9wHuO
 hmY+MO/SUYN4odDUpRxqreov89sgYN5Rt59dhFQ7XA1m1SEcKMl9P2aL0/s1mRLbThDj2QNDAV6
 kuy1S/Di1fi8MAUBS3krY/4GDgcLxBPLhkuZs6nG
X-Received: by 2002:a05:600c:8b32:b0:46e:42cb:d93f with SMTP id
 5b1f17b1804b1-46e71109fdamr47105335e9.15.1759599232264; 
 Sat, 04 Oct 2025 10:33:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiBNf5h67oRHi8EOKLADw3S/lYflR0OAAt4a/CkANt9g7YRg+9BTFG2wcpCeD9/B3A3Zv7kg==
X-Received: by 2002:a05:600c:8b32:b0:46e:42cb:d93f with SMTP id
 5b1f17b1804b1-46e71109fdamr47105185e9.15.1759599231814; 
 Sat, 04 Oct 2025 10:33:51 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e7234f69bsm90890695e9.8.2025.10.04.10.33.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Oct 2025 10:33:51 -0700 (PDT)
Date: Sat, 4 Oct 2025 13:33:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <20251004133102-mutt-send-email-mst@kernel.org>
References: <aNE0Bp0hsA31sLCJ@redhat.com>
 <20250922081403-mutt-send-email-mst@kernel.org>
 <aNFF8wsycqqOTc-x@redhat.com>
 <20250922090748-mutt-send-email-mst@kernel.org>
 <kmdwf2xbgtvqiijw7mjd4ocqixvznaeszbr5zzfvuhaqrmpqn3@wdt4fhnocmxv>
 <20250922093013-mutt-send-email-mst@kernel.org>
 <87y0q6mscw.fsf@draig.linaro.org> <aNpBqlRmdOac7U99@redhat.com>
 <20250929042410-mutt-send-email-mst@kernel.org>
 <aNpaSpF_qY6z03Q3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNpaSpF_qY6z03Q3@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.477,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Sep 29, 2025 at 11:07:06AM +0100, Daniel P. Berrangé wrote:
> > Well that's because e.g. kvmtest actually depends on pci-testdev.
> > IOW it's actually supported.
> 
> This again just sounds like a downstream 'support' rationalization.
> I'm still not seeing a compelling reason why the vhost user generic
> device should be disabled by default in upstream, especially if we
> mark it as an experimental device with an x- prefix. 
> 
> With regards,
> Daniel

We can do that. I am still somewhat puzzled by whether making
it unsupported/experimental addresses the actual need, which
seems to be to expose it to end users?

Once something is used in the field, we can't take it back
whether we added x- to the name or not.

What are your thoughts if it's not marked as experimental?

-- 
MST


