Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D328FC87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 18:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujiw3-0005yv-GS; Wed, 06 Aug 2025 14:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujiw2-0005yO-7X
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 14:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ujiw0-0008L6-ND
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 14:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754505138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SIQZ6zbrFlLXlLqdwqUISxCqOXDk2B5Htm9ZAs/EVRk=;
 b=e6MP/fknj9JseOIYpcrBvd6azPLKlN+ppqIckF4wg19+bk6yxfYsJXnjd/5soF7tjA/eB6
 xmWJUfNGBHug361RjjeJybi0KSQHwvX7QPDsjsYNplkjIHL24Q7Z0A39F/3pDLaji8EdgS
 mAJl4QMCK2HnRX7nTUfuwpUiPgbF5GU=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-xh_4w43IMlu089FXcOfK6A-1; Wed, 06 Aug 2025 14:32:16 -0400
X-MC-Unique: xh_4w43IMlu089FXcOfK6A-1
X-Mimecast-MFC-AGG-ID: xh_4w43IMlu089FXcOfK6A_1754505136
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-71a29bab154so1971927b3.2
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 11:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754505136; x=1755109936;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SIQZ6zbrFlLXlLqdwqUISxCqOXDk2B5Htm9ZAs/EVRk=;
 b=NwmofNKKJz0RgxD7kJaWeXrcyNltXd6KDzdLZort0D1xLEfjtH49DSlxvtNSGxxggr
 EMl+p+qJQ0hokuSsEf+s8GOHfutUrNBCnMlloOFEUifkZ7xWTZH49bTet3OPA9RX83xY
 pah4FZnedRDXfT0Xr31eJFoQYZQO2O6PT6R7kRhkjy1kW1vygKwL8szHr2ijsxk1Ypla
 azIQ1nvoiYr08Ho9+09+EsZmsFYlv0J6pnsZ8U5tA1o4oF7+8sdKNmAVjA8wYa6OPJ2y
 zLBCM6UOTZnGeWTwxwSWjoNUrZ2U0BBnl/2+h8rncelnD/84FA4zIyo1pMsBL5Oq/95w
 9WiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTvzB6s8Ri5pks1vwystfZH9Ko7Iv6AF65v1cqGdvL2+kU/0yv8g/ylargvMOLFK9+xmtUR3N1JkVi@nongnu.org
X-Gm-Message-State: AOJu0Yw34TrfRpBx1oxD5F7rSkEo2jgGu7bYhwW6doHtsoaUX8LrdRI6
 lfL0SD1v7N/54PmcM+9FADz18SB/X1gu4E3EbeKNmRwMZhKMi/ZrY8pCOool+6EqsFLetmh6Dah
 hJ2octMQ/sZhkHvFA3fWAYaFgfU65uQek6R/H3TWZ0NpfqNmDIVIFsw3f/Mv2BAq6
X-Gm-Gg: ASbGncv+7wisc4EH81IgD6sE8sms/SlfO0bjA3rz0cepIy4yP8K700fJ/AKGHutIDvC
 7Kyc+4929HDLPX8a2bgA0kS2cngUHTQRQTglTvZY5qed2/SuIO1fFD/FLJWQmclBb6y2BkznYfw
 d4M1/FWPbe1n3oNhDmORLDRWvYyZyKqRlJEtSbfVbYvLazpT5FYcvM0WkQgxjwXhhfjZjzbhWaQ
 LMu4hdRF+PIzTexzO5gNLW2/Vc6Q/h+FkwxmP3M+YP65xGEDZdwdxKiZAcMTADsc1oLbPknJ/ZI
 kpgl56B1+7XyJdApdTSMXSmqg/wQ+pKew2Jf/CFCGfZbc/nwn+HrTweLMPff3cHNgrUYZkUdmpX
 jal8SIRcbx8J48c7L31SSRg==
X-Received: by 2002:a05:6902:2587:b0:e8b:3e67:b90c with SMTP id
 3f1490d57ef6-e902abbe120mr3585371276.16.1754505135981; 
 Wed, 06 Aug 2025 11:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwfONToVoNbHCH0DhBF3JUve0yR7zJ0vSlZGIRisAFAOOU8lTllKnL6AeqJF1X40Cp9B40Xg==
X-Received: by 2002:a05:6902:2587:b0:e8b:3e67:b90c with SMTP id
 3f1490d57ef6-e902abbe120mr3585316276.16.1754505135187; 
 Wed, 06 Aug 2025 11:32:15 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-171.dsl.bell.ca. [174.89.135.171])
 by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e903936daf8sm93464276.29.2025.08.06.11.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Aug 2025 11:32:14 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:32:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] migration/vmstate: remove
 VMSTATE_BUFFER_POINTER_UNSAFE macro
Message-ID: <aJOfq598IAl2hQU_@x1.local>
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <20250802142115.41638-2-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250802142115.41638-2-mjt@tls.msk.ru>
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

On Sat, Aug 02, 2025 at 05:21:09PM +0300, Michael Tokarev wrote:
> The only user of this macro was VirtIONet.vlans, which has been
> converted to regular VMSTATE_BUFFER.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


