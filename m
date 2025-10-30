Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AB3CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:04:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEW3j-0004aV-L1; Thu, 30 Oct 2025 13:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEW3g-0004aK-Qc
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:03:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1vEW3W-0005m4-C7
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761843798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LZjZRaLOtJsPZZjIG5rMMTzjvJbnZFMIpxZu+krmtis=;
 b=JBB6pEtIEKpv7q2D7wvSsxEZ7HPj8uo1Kn2BN4hLWY1+5fhZ+fc8ZXUh7WzYBkPnZ6C5QL
 9gQ+lYbSF94dbhOlwmlrgg3C5J/zyPgcZAX3/krgK1MIEXSEvplMgZA/S6eGcdMIlzywaV
 PKmunINnXKsau7zZqXiQOarXlUVmalc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-5Wwh5gAcPZmGiy08Qc8tYQ-1; Thu, 30 Oct 2025 13:03:15 -0400
X-MC-Unique: 5Wwh5gAcPZmGiy08Qc8tYQ-1
X-Mimecast-MFC-AGG-ID: 5Wwh5gAcPZmGiy08Qc8tYQ_1761843795
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4284525aecbso884153f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 10:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761843794; x=1762448594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LZjZRaLOtJsPZZjIG5rMMTzjvJbnZFMIpxZu+krmtis=;
 b=A7lFMyf2wLhLawPtE8hk/EofbtqNB3z58tKNqgqbVJJj/Q9mwfPDchD7cZtmR9cu1x
 P+EoVqi5Vd9oNUvmttLkM1ryU7xMoJZ3xzv9eQp6mMlU9LMuJcxjjy+kdSpOVziUOrsX
 sd/cIfr5Ycj/d4CMtbCjEmP5VMPUsPxVAsyE5PUwMU2lk3LZD8RNuUtPnXo/dUKk+Eqf
 w/SiHSJEidpqu0vdWBbCHfCRWAVlEl6erEqz9UyZb7QV1YI7psJ+fSfWCKCXmhi8EHm7
 c8keYpktQfBMgC6EHBj2Cn7cd6sI4Zg8qJrJ9UTwSGTCGx8Rh0AbMIsCv16N1gn2ElPm
 xzww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVc4VOL0zZTvk6cs0QaAqMUL0BfzhDSXsaR6RScYe04J7ae4WEahDCPt80sVlEm9hFJLDk0OQHz2W/t@nongnu.org
X-Gm-Message-State: AOJu0Yzy5LFM0GBlg1zohkZi0849yxusgUebswHu3353ybNOJfCaWRc9
 bYWTru/HIFnCDq6V+mnxLWpxZQ2+KTnuef6f3TIdc06ytMofNfubPBKKSYju4WqpTA6MJgZih+Q
 ut1+rY5Yu0nIJrEdUM2NGjfbLW/Sy3miGIS8g3W/t+kF97ZFXOCdvytClR7APOLua
X-Gm-Gg: ASbGncsBPzjk2Fd72g2r/HZsqrPdoaqG6WG+9XLRnaA6bzkSJJFd12ROPF0mBBns+kK
 SO1/j6gCMK4LZckBVe2l2pGNJvS0H4x4rTmYlmOZjmgCM2OXbcoZMDz2HBBmG9Yrsjhekjv/LxD
 BzrEwfvQ5fCr3l6rZz05s2Hd778kI5tQoznX10uLOMig5tqBnv+z7FmQsRT4v6N5nH7u95EQhmp
 qsnX9maJlpHGsxSjk/K2eG9I5fyLsMNxNNSb1gALfP6EzWrQ/YQNqi1iBRx6JJA4PvG6OvKnFnP
 ZTjPGW+hxK5LND4ysTEMZuSvEOg2/aUrkdKF95hiAQWsR8uPUH0epseEz48C3M31lg==
X-Received: by 2002:a05:6000:2011:b0:428:3d1d:6d15 with SMTP id
 ffacd0b85a97d-429bd6c48e1mr242898f8f.57.1761843794012; 
 Thu, 30 Oct 2025 10:03:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGQ/vREKsTEQUFXOTlhVWOt22OWlODTOn7zGHB0gTvf6RiahodE4HmcU0lC8bq0Gfscskhjg==
X-Received: by 2002:a05:6000:2011:b0:428:3d1d:6d15 with SMTP id
 ffacd0b85a97d-429bd6c48e1mr242851f8f.57.1761843793298; 
 Thu, 30 Oct 2025 10:03:13 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca569sm32264009f8f.12.2025.10.30.10.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 10:03:12 -0700 (PDT)
Date: Thu, 30 Oct 2025 18:03:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL 21/28] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <20251030180310.13896933@fedora>
In-Reply-To: <de075ba3-b1b8-425b-9cf9-cffb7eaa481a@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
 <20250829125935.1526984-22-pbonzini@redhat.com>
 <de075ba3-b1b8-425b-9cf9-cffb7eaa481a@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, 27 Oct 2025 15:38:07 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 29/08/2025 14.59, Paolo Bonzini wrote:
> > From: Igor Mammedov <imammedo@redhat.com>
> > 
> > The helpers form load-acquire/store-release pair and ensure
> > that appropriate barriers are in place in case checks happen
> > outside of BQL.
> > 
> > Use them to replace open-coded checkers/setters across the code,
> > to make sure that barriers are not missed.  Helpers also make code a
> > bit more readable.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> > Link: https://lore.kernel.org/r/20250821155603.2422553-1-imammedo@redhat.com
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>  
> ...
> > diff --git a/target/rx/helper.c b/target/rx/helper.c
> > index 0640ab322b5..ce003af4219 100644
> > --- a/target/rx/helper.c
> > +++ b/target/rx/helper.c
> > @@ -44,7 +44,7 @@ void rx_cpu_unpack_psw(CPURXState *env, uint32_t psw, int rte)
> >   void rx_cpu_do_interrupt(CPUState *cs)
> >   {
> >       CPURXState *env = cpu_env(cs);
> > -    int do_irq = cs->interrupt_request & INT_FLAGS;
> > +    int do_irq = cpu_test_interrupt(cs, INT_FLAGS);
> >       uint32_t save_psw;  
> 
>   Hi Igor,
> 
> this patch breaks the test_linux_sash test from 
> tests/functional/rx/test_gdbsim.py. cpu_test_interrupt() only returns a 
> bool, but that code in target/rx/helper.c checks the individual INT_* bits 
> in the do_irq variable, so this cannot work. Could you please have a look?

sent, fix should be on qemu-devel in a bit

> 
>   Thanks,
>    Thomas
> 


