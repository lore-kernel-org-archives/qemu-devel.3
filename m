Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43732F54ADB
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55DF-00018O-OD; Tue, 24 Mar 2026 13:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w55DE-00018B-1e
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w55DC-0001zk-L5
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774371997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Q684ST5DOARb+Fbhc2cf41ycX0oUly+JCOri3kYA5X/axl1VUmYESMUhvQcGiyWax2T+WJ
 EybomUrCWYmxNox8Iln9elz9UkiHWJozFLDXyxX8tcJQEa2kAPwKaT78hNo98JDF3w1nrV
 6GuNEQLNcm1JilDMZFhuQECuhLWPVA4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-vfZndAmKP2ezJ4uaBGn1Rg-1; Tue, 24 Mar 2026 13:06:35 -0400
X-MC-Unique: vfZndAmKP2ezJ4uaBGn1Rg-1
X-Mimecast-MFC-AGG-ID: vfZndAmKP2ezJ4uaBGn1Rg_1774371994
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4853b5b0fafso61968095e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 10:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774371994; x=1774976794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=rJuf47nOeJg60Pn/3FNFeEAAIV42XaDAOUyuWNJ0sTai0Rq0J08VOopnD7i2aJwr6U
 giQQ+1rqXIna8CXGzzcQD++NGcYiWi3sTOKk7h2g6JeJ9TIPbArLdV321uCxWWA3uWx9
 /dqlEQxgee2Mzu24/t6QeAyO4A8Ad3lorX9hUARGJaOOKNF061zJ9QisnmK8oBYZbj3/
 ofjA3v0PyIbO+vb8NBqX/HLo5NzadCBwwpJB456tD9cZ/ZMWB+usLS0FAbv/276HfAma
 khWHuXF75w6mLrCx+WbY1QGqctKKsYj5LLkOf3Cke1YDWza+vegKzFIvAd9hBC7de/lk
 ksbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774371994; x=1774976794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DYW5YqjqqvZryDQi/p70rq5/CoGUYMeHPx78/GrpEAdRkr4OsZ3C9hiVr11uQqh+2S
 ZWzHClYqrsuNwzu4iLt+QIOlgsIa+rYGaLarYqyhrtw5rloAnPCktKIbSnHGDj/zNVGh
 gaLsWFujtCsz0/7BxletTJwcTYrGCIthHG52DFC6esg4VN30om+zc9IHbWnbqRPSwWFc
 r4SpCnzw4OpYOwEii39tFZWOOdOkKtfiBkqI7XJHN4ed9ebTHyW0sVwy+GuXc7cMlCTM
 3O3S9osFu7AndaraVuNEE6XD4LmuCOeJkcfnFoMdWoEocCGrC4OEdU9hAZl4suc2XCPA
 QcfQ==
X-Gm-Message-State: AOJu0YwYvetD/jAKiHJ/z90TXDlkfuOHl5WHJmzfSzTKB9FTkYjTFrGF
 Ttmx6oiQa5ZxLMjLNGNOZTUUD32BK3++dmeUlHvnPPSTJ3NZ5Tqv0oloL718GKIFqRox2oIyWZn
 BVFreo8oAS64fVXbV1EdPhfRZ2ujlMq55txaXaA3abdJqlFZvc2k8OHk1
X-Gm-Gg: ATEYQzyqrwOkS6fBys07q5dHGxwQFBrPQE3uuygpnL+GVv+Zg9L/fqYJesHH3O0cM9E
 SmUssDftJXEpkB+i3FicZx5uj/XiwTx04qKxwQJJbF0zQWJLS/0grJSd0ypRTxmso4fTbzWAatk
 LMaUB6rMCGFeXO/q9h2AyyC04LLm0WQACtTJRB8bSdVm9JqyXhjJPR/BcpdpHFpRW6GxWIW8WZa
 O9FCeJEBy5KnqmO/PoFOS+LNThr75klj0hm1DbwbrirTiO1zYWNd8tWPek5ehGHM0q1yru4xrpd
 DgvTrqL4b1ghCO3edDIUKpbCfWSvJSedzHSsolHQiuo+Iz3T/UgIVSarVUrHQEmYHGT6WtNYN7E
 vEqdDw0SPAdvEGmwgz5MkuMa1tv3M288CoGxaggNAbTgK50xHOEWiU/yvGVBbOFBAT70jaNuY0B
 ejblGKA1o39vXkp4Qr8wkCk+AW
X-Received: by 2002:a05:600c:4705:b0:487:300:d9ca with SMTP id
 5b1f17b1804b1-487160a2a33mr7624425e9.31.1774371994385; 
 Tue, 24 Mar 2026 10:06:34 -0700 (PDT)
X-Received: by 2002:a05:600c:4705:b0:487:300:d9ca with SMTP id
 5b1f17b1804b1-487160a2a33mr7623925e9.31.1774371993976; 
 Tue, 24 Mar 2026 10:06:33 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-487116ee562sm71154185e9.15.2026.03.24.10.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 10:06:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Jenny Guanni Qu <qguanni@gmail.com>
Cc: qemu-devel@nongnu.org,
	thuth@redhat.com,
	berrange@redhat.com
Subject: Re: [PATCH] hw/audio/sb16: validate VMState fields in post_load
Date: Tue, 24 Mar 2026 18:05:14 +0100
Message-ID: <20260324170514.789007-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318192918.65481-1-qguanni@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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


