Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94741C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpzc-00083f-00; Fri, 01 Aug 2025 09:40:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhpsA-0004wr-3b
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uhps8-00005A-4x
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754055149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OUAXl7ufhpeuMMCkiIvzQ2+72FjO8lIXmLzyBYZ6bvI=;
 b=Mu1O2rm4B114fOksEsedA1WebojGsDBCUpmoitg1hsEUj722nTC9LwiOLs0k9dz4aOe5PF
 H8fQIdq/bC9aZx+r+PC0lUIkvRwN4bmjhDhZUdcD6ckf685G9smb9igxNCrV81gV6lUzIU
 uMWZzG8Gc9dqQVXrIyV7Db6tf033Kk8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-xstpXsRePjOCvXQ5i98-vA-1; Fri, 01 Aug 2025 09:32:28 -0400
X-MC-Unique: xstpXsRePjOCvXQ5i98-vA-1
X-Mimecast-MFC-AGG-ID: xstpXsRePjOCvXQ5i98-vA_1754055148
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e32df3ace0so92855285a.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754055148; x=1754659948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OUAXl7ufhpeuMMCkiIvzQ2+72FjO8lIXmLzyBYZ6bvI=;
 b=ClUzUj/Lf8YGAZ52DNGpWAyWiPBtZ3v6xiYneBJ801obLnSitAqb94F4ZQR/j3didi
 ZVZn39IxAtq+F6SxF81OrCgt1V39BfTTxO/zCHIveya2zFlokxzi6hahZMnskaxMelht
 m2U1II94MgUWrzsbF5xQ93hNB/OZSj5gMRCYpPflcvZq16VLBE2tfE/FOeMy5ceGp+lS
 D6v2L9Aj7/zjwP80jyGOPr9Zp2iv6Jwk6XRqwO9QbGydwm419u739LfupaUwQeyd8Yrr
 BBOLyqy/BYfLPO053x0lg8M9Y36ttaFuBRinIVlqF5wMtyxVD8XUmRQzybsOalWleEyB
 p8yA==
X-Gm-Message-State: AOJu0Yyg6fqec6HwhN1qImU6Q2COjYzZ45O2rlTEI0Gw64BDkFQWOI8x
 xJGrCDlJSfnnkXNCzWgsuxKPEm/LZOs3cozixP9kYHmu3NBspHlWmy45t4V3/hxLlG20shnMkbl
 EZD7LKfEABPJLQrlumJjif5V1iynU4f6mJu8/CRdvHky7XZd2kS1irRA4
X-Gm-Gg: ASbGnctC+aAu9klRnGySJrCpecuso5lRSiiNAQW+ss0rF7luSTsguNkpeg0L+CBU7tL
 zPpZ9BCj99xnh/gHfJ9FeVev+XX17MwZJS3X1GS2SvqDY+DQG8aqofziN5y5B5CddcBGffJZwBs
 OuG0dIQF0w5SVwoi4dODkV8n3qVtkFItW1Ac6gegU3aftMVBFh5qW7ApUtfXWzr3vYteUyp033G
 kcNvuEPiJEbqQNmM3XSpdl2+E33H9p7l7YsiV9w9jxVf8qrSVJIQCPh4STzDDmSYTm5QkNmopJP
 6S0ebs6Vv21JWnvWJzx+1JuNFhGNNZ+i
X-Received: by 2002:a05:620a:43a8:b0:7e0:9977:a803 with SMTP id
 af79cd13be357-7e66f3c648amr1494109885a.54.1754055147743; 
 Fri, 01 Aug 2025 06:32:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlFdIcrQHLNp5GUtcEZ2zOm/H/6tPyT0COfkYxajIWlxcb5Asp8oBwwNWMXKp2wDmCysJYaA==
X-Received: by 2002:a05:620a:43a8:b0:7e0:9977:a803 with SMTP id
 af79cd13be357-7e66f3c648amr1494105585a.54.1754055147236; 
 Fri, 01 Aug 2025 06:32:27 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f7083dcsm218984585a.41.2025.08.01.06.32.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 06:32:26 -0700 (PDT)
Date: Fri, 1 Aug 2025 09:32:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 5/6] hpet: make main counter read lock-less
Message-ID: <aIzB32EbLiASm9Dj@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-6-imammedo@redhat.com>
 <aIqZZ5bePh7Jmq3c@x1.local> <20250731103210.292dfecb@fedora>
 <aIt3Xo8dSKusoxA8@x1.local> <20250801100645.133727f0@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250801100645.133727f0@fedora>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 01, 2025 at 10:06:45AM +0200, Igor Mammedov wrote:
> docs put qatomic_inc() in 'Sequentially consistent' category,
> hence no manual barrier.

True.. I somehow read it as a _set().  Maybe it's another way to prove
memory barriers are error prone, by making a mistake myself. :)

Thanks,

-- 
Peter Xu


