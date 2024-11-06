Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8821D44D73
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 14:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ge1-0001cu-1a; Wed, 06 Nov 2024 09:04:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8gdx-0001cb-6D
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:04:21 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roman@roolebo.dev>) id 1t8gdv-0003Ng-Sd
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 09:04:20 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-20c804409b0so3651395ad.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 06:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=roolebo.dev; s=mail; t=1730901855; x=1731506655; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WcZYRfSCCvNWO0FzgSSbt3rUifbFWUqzLBopV0UokCk=;
 b=fuY5ZWXFZN6NfMKA4Li7YEASWJzumBpwGjwAnaJNdTiI9P1At9nt6T0QNp8QYEZfF+
 JdQk5i+e558P/j8FyuVgacYy63q8heB2QHk/YLgmmoIltkV3fMSDvS11oETUcMFPpv5q
 1Xx5x1vZt6CdisdCR5cm3HMZmtFi+C99Ih6yjd+u5+LZQcyiW/RvYrnqtjTegm1gUgAN
 JH3jDDlMpCdlB/I5JJ6X60IF5wV9q8QF7eaaqFrPyHj9Z1ABtdDnyQFiGVGjhgL06BUc
 iBP053/IJOX/69+c3C9jUwBRxP80heDSQrUOOibS6p8M7QxBeTBoHZXFqiqnXSYxlJjQ
 C4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901855; x=1731506655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WcZYRfSCCvNWO0FzgSSbt3rUifbFWUqzLBopV0UokCk=;
 b=cknffixGK7lr8NZMGODWKGiea4Sabka68kFwc1tZpkCBPogzbhkgUVD2J+mQzsUWGx
 //L4zP0/f61CecRjIMKAPaMchOsa/d5PfdiNplb164+NwtQrxb62nh/a3j3oL6hE1Yhe
 ET32/E0dqDNR7TZqjRCJ+RM+MGmBnmUEVsQJpPz33ct94lKEGsVGF72QmM05EsDgUG4a
 NTik+A/9/iGM692LFoXTKZ6xuVa+OVsWN5nfZHn0lB7ZS1XLTL07cPTqmLsqYrB3pOMu
 WuhKBN5199j2eFRuju0RKTv/0tIFzBO7aSKfLvPNIhfH6jK9oN4V8Nd6mZ9+a2hcVl4S
 t/bA==
X-Gm-Message-State: AOJu0YyW4Soxy+7UbzUTEEVGPNysy7fOP3PuPe8XHDunVBOCoLqXzdFI
 ayRdx/GPmNQjEzO2sArN+hNWyx9TcYBNEsHDbNyAD/bEGrsbtTAevQNFhx1OSAY=
X-Google-Smtp-Source: AGHT+IEBz5PNa2ctv4nMwOeuKYAGifzZK/Mb3qHzIjXWwF0EbnygIk5tsd2q7nFR4G6TUPGOZxXDEA==
X-Received: by 2002:a17:903:c8b:b0:211:ebd:e35c with SMTP id
 d9443c01a7336-2110ebde6d9mr136598615ad.0.1730901855432; 
 Wed, 06 Nov 2024 06:04:15 -0800 (PST)
Received: from localhost ([2405:9800:b660:1d69:184b:7485:e878:79c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211057a2c02sm94604095ad.128.2024.11.06.06.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 06:04:14 -0800 (PST)
Date: Wed, 6 Nov 2024 21:04:12 +0700
From: Roman Bolshakov <roman@roolebo.dev>
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, dirty@apple.com, rbolshakov@ddn.com,
 pbonzini@redhat.com
Subject: Re: [PATCH 4/5] i386/hvf: Raise exception on error setting APICBASE
Message-ID: <Zyt3XEfGtwobC3-R@roolebo.dev>
References: <20241105155800.5461-1-phil@philjordan.eu>
 <20241105155800.5461-5-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105155800.5461-5-phil@philjordan.eu>
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=roman@roolebo.dev; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 05, 2024 at 04:57:59PM +0100, Phil Dennis-Jordan wrote:
> When setting the APICBASE MSR to an illegal value, the APIC
> implementation will return an error. This change forwards that report
> to the guest as an exception rather than ignoring it when using the hvf
> accelerator.
> 

Reviewed-by: Roman Bolshakov <rbolshakov@ddn.com>

Thanks,
Roman

