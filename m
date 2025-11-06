Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512C0CCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 16:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2eL-0004zt-Ja; Thu, 06 Nov 2025 11:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vH2eJ-0004z7-BW
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 11:15:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vH2eG-0004sL-Vu
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 11:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762445743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DX3uaLp12ba8vcNsVZdABz/k+raMplVYGO6GWTdfqrY=;
 b=Jxl93ADndLsV6VR8ot24PHOH1Lo6VlMgiYH9O3hdy1vE0hrgWS/K/JhCGbIyevefNos/aV
 tLRKo5xqcpBWo4p+HRGa9xrfTCASLA1cEBlNKPqa5tf0P9/UDG5v6rsbQdtDwm8VjayJdu
 8L9gOBq0lKdKy4szDfgrzjjdO8D4DwY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-mME_6xa_M2mrIH5upCuC5A-1; Thu, 06 Nov 2025 11:15:42 -0500
X-MC-Unique: mME_6xa_M2mrIH5upCuC5A-1
X-Mimecast-MFC-AGG-ID: mME_6xa_M2mrIH5upCuC5A_1762445741
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-89eb8ee2a79so255560385a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 08:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762445741; x=1763050541; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DX3uaLp12ba8vcNsVZdABz/k+raMplVYGO6GWTdfqrY=;
 b=nE4Zi0Y9AXTkB85yJmMJxyKcI9F5qYwnO3SeAiwrolp16tfdcbqhgTwf8Qe/su2MxM
 K4Nkkw9b2N05seIkyGKq/nFj8TBUvD7Rcw7uDI9TejPQ/JHv/OfzyyNiJVV3rNpveqwU
 /QnYuWWKr09sHO0c5twJt0HG4Zheydb6dhUgD4KyVxng8fuOemb+7NYy9BDScKoRrC6D
 dzT5DFKnD8D7+fwo1OLt0a0QYccti09rKDbE70BFwiv+IcOr1vx3aFdjDDtwUpSW6xeL
 OHW/Q1XWrNVHpWJ/nxTPNIaVuPFTxHveJyF1SGWyGK0UQCrlSS92ElbbAFiX03s3+M5u
 a4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762445741; x=1763050541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DX3uaLp12ba8vcNsVZdABz/k+raMplVYGO6GWTdfqrY=;
 b=L/soXf0noVPnhvu3h7zOHVI9pqHO9KV9YgHnmC/bn8BzdlMv8Zabz6WvwRoGUDzw8e
 nCj4n2B6a0S0xrkT5nMoLiqHuC+J5bJpQguQ+LI5frGS+AYZb0V0fqoeUoRXdfhoHCcn
 4WehSp9jTTLqNYpNwiQpKkuQla7HmfBZ95I2mq3HCLLTDiZJOCTynfEZ+nal3hPpXMhx
 COckkFskkcjx17jq0fXPyoKCyzQ3DM/MZdJiiPa9R35SSxViYH/fSVnWrlm/pZcif61L
 /CsPhVJru+8Jkn4PUuuLcfdTwNnq/liW1+LcaCOCo/2SoqdcWbLDQ+LDSLypZMy/cQFJ
 xuhg==
X-Gm-Message-State: AOJu0YyeN8nchbmRZIuQA/eR2gOxbDH0FASxFJseVITwyvqpMjwzEnKm
 VuLWNkN4/1tqd/dWj9/l2FTd0K1paQ2ItlwuNHc3yhzGpoBBin7SSRSZJen2n8fi89Q1EmCQ9d7
 kpX+sWawVLovSR8xqB/EWmASXmGg4/HP03c04B6l83hNjCL+TdTxR73c9
X-Gm-Gg: ASbGncvmx0TXm6H682MMR0HPuqjA/kOmCzzazeHKB1wAuqLa0A44k3f1TlZK2BWQ2TW
 fwOZS1/q1Nsu/1KyZvGoZ37FaOye+KJtaToHxqg1gYuOmURyQuehPzAVdAmfEneMSU5yF6dNe6A
 I6YzFJSFrhPuavu3Ol8sGgrjePSXj3mJK76rKaPPChaLeBWIBZP1sFDzHNVJcpgdK8KaJPAPqlD
 TR+QG2/e5ACTRST476hXaDmJB4EvKVTI2FzKzZNoPma2N9Wadvr5aYleksTf2WrR00hHrTX/4XJ
 Z+LjxqwXlv2x1dfORCD+d3awIsVp+DvHpZHrI60WIypNsYu26mAgv5j7kUPDN1XiUZU=
X-Received: by 2002:a05:620a:7107:b0:8a2:7cda:f03f with SMTP id
 af79cd13be357-8b24528af5dmr21486485a.16.1762445741210; 
 Thu, 06 Nov 2025 08:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3udJ968grNRsWcHG+yfb/kok3f1cjW54CwHJf8UXORKXLutS0r59S7J/hrUqOg9iNrK9bkQ==
X-Received: by 2002:a05:620a:7107:b0:8a2:7cda:f03f with SMTP id
 af79cd13be357-8b24528af5dmr21478885a.16.1762445740531; 
 Thu, 06 Nov 2025 08:15:40 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b2357dbebasm225619185a.31.2025.11.06.08.15.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 08:15:39 -0800 (PST)
Date: Thu, 6 Nov 2025 11:15:32 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] tests/migration-test: Check error-desc after pre-switch
 cancel tests
Message-ID: <aQzJpBZNzwoL8na0@x1.local>
References: <20251031164956.3409661-1-peterx@redhat.com>
 <4r5wbhkkk346usjdgvnc3epcom3he3y547p3smxbkvvnk677tz@e4hsizwn5sfp>
 <aQuq-ONNdEEJKmId@x1.local>
 <zwihgptp2i2syyyakkwefg2pfhihurf6c5wlrvgtlzfydxjzmc@vvwjl6gk373e>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <zwihgptp2i2syyyakkwefg2pfhihurf6c5wlrvgtlzfydxjzmc@vvwjl6gk373e>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Nov 06, 2025 at 12:27:49PM +0100, Juraj Marcin wrote:
> On 2025-11-05 14:52, Peter Xu wrote:
> > On Tue, Nov 04, 2025 at 01:35:53PM +0100, Juraj Marcin wrote:
> > > Hi Peter,
> > > 
> > > On 2025-10-31 12:49, Peter Xu wrote:
> > > > error-desc should present on dest QEMU after migration failed on dest when
> > > > exit-on-error is set to FALSE.  Check the error message.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  tests/qtest/migration/precopy-tests.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> > > > index 57ca623de5..5f02e35324 100644
> > > > --- a/tests/qtest/migration/precopy-tests.c
> > > > +++ b/tests/qtest/migration/precopy-tests.c
> > > > @@ -759,6 +759,14 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
> > > >      wait_for_migration_complete(to);
> > > >  }
> > > >  
> > > > +static void assert_migration_error(QTestState *vm)
> > > > +{
> > > > +    QDict *rep = migrate_query(vm);
> > > > +
> > > > +    g_assert(qdict_get_str(rep, "error-desc"));
> > > 
> > > I think it would be beneficial to also check if there even is
> > > "error-desc". That way if the "error-desc" is missing, it fails on
> > > assert with SIGABRT instead of SIGSEGV inside qdict_get_str().
> > 
> > IMHO it doesn't matter on how the test would crash.
> > 
> > > 
> > > With this change you can add my:
> > > 
> > > Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> > 
> > I would go ahead and merge a test patch if it had both lines, definitely
> > not a huge deal.
> > 
> > However strictly speaking, qdict_get_str() is actually pretty efficient to
> > make sure both that exists && is_string when used in testings. Would you
> > agree?
> 
> It is an efficient way, I just thought the less efficient might be a
> little bit easier to deduce why the test failed. But if nobody else
> opposes, you can also keep it as proposed,
> 
> > 
> > I definitely still want your R-b one way or another!
> 
> and also add my R-b.

Thanks.  I wanted to have this coverage asap, so I collected it for -rc.

-- 
Peter Xu


