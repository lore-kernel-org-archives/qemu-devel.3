Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A36DA1125851
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0M6R-0005No-2W; Wed, 11 Mar 2026 12:08:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0M5y-0004nP-RR
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:07:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0M5v-0006Xq-4y
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 12:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773245253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Yx6cmIri3JI7PovEHFc6WB7atPr2xGF/4diRHpJZGqciIENW/Zg5E/jo1Du0nRY/39Lz4c
 0iB+HWe7sxy96P6ntZVyKAoBte5yQek0ORV0U49G//QAEqeOjJnvKkzWSNVM4oDZdx3eHR
 X9b5fnPNQbXGnQSVmITKV06q5xZMFcU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-zHmrfU6CMoG33XM7y5IYVQ-1; Wed, 11 Mar 2026 12:07:32 -0400
X-MC-Unique: zHmrfU6CMoG33XM7y5IYVQ-1
X-Mimecast-MFC-AGG-ID: zHmrfU6CMoG33XM7y5IYVQ_1773245251
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4853efceaddso32415e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 09:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773245251; x=1773850051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=YYGKs6iQLQVwGc5Q67UFeQIx5DdwKIUi6fxkvao3xB8K2ek0utgqIJLfJBj5Cc/ay+
 WefM9H6JfiwoZAIgSO6o+YHhN0fmId2VDHSpoRcE2ZPh5eRXl2pi3AMo5v/Q52hwRzd9
 y5g3Wiivo6sQgHXQK89C+fxoXKh/EadS7OWGUIvnzCn3NSdRD27n5CXR04FEQ9rt3qoD
 mAuScGua3d6D3JJaAMYxsBlm8d6CEk6oB+REsr8xetl0xHVS0pr1hE4y2vCpfo1G0oJ7
 InQ0P3IfXVUSAxca9kbFN19rgznNvdnjs0decFau+T2TVXGkZzdmae/OaqRdsQAefzuD
 JhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773245251; x=1773850051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=rNJbkmCtpF8tqskLhF4kH0tljWeAw9vV5befw5rXkBV46L7zWjHts/1UA6ia/lrQec
 +A77ofVhZEVU7CFs6Vi34i2B5+kedU5VfacAhTEJustjGUCwQw5+P8An12BD4MO0JNgj
 XU0VcU8hJfPSgzzwHGZUB+zY4IlK5ZUR8rnmVi684vdnv9+JLXTXswS8mpRcY4sMJKjL
 xUjLGZt0rVFLqF09HK5AZb6Bw9CufyjZpfk7+258JVgQFDt/+owG5y0Ni85BxR4xZJTD
 DckiDa79w0jfUJjNJPCZu9qXWINMDas03FJLg+rsTi+ijkt1e896eW5MdTJPmpBvEW+n
 6izw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfS4+ksQMjc3HVigcZL/0ddb/lHtZo/gewHqfjRE0Ow2mRh1upYwVYmswZ6diHBk+XrtJWQQP7v7RY@nongnu.org
X-Gm-Message-State: AOJu0YwAYuBM9qoAqzJlwTlqvzvtlU4judJGgb4SwErQg4933gi2lIE+
 sLQ2z/8AxN0Yva3CwU/3MO9Cc80T3j5Ff3qV1iV3N7s4kVwj+3bJnNIsDyMviM48chuJd72jKuB
 cVOpn1BIKAGwrwlgsiPKSCQK33lT/aTuE7qmdpjQiBNSSQj7l3ma5pL3y
X-Gm-Gg: ATEYQzwN5r+5mNX41lOXxqn7wwn5XDgSPsj01ev5NbL8oGXORyYcp/ZRhFAg91N5H4n
 n9U6T6mqQmexILuZmmeJ0mDvW8w3YkubqZlZ5psmjK68tPq0ErQz3C/IH4J8DPD23EdInigh+1I
 9Xkfi55IcwyIAfaXzFyz14mmyeOkPUQr8y+X2SxcN3lLfbDbSO3AWL38FDhxkGCA8wtDWyY+TfU
 TxfSFJkdRJhtBcTnS0/mPj6+qENQUJx5ELtIWQlAaSweutGgv5Q+FHJSOoNwMVJuIIL05xYepLC
 LyKOL6ROJ0ndBjFSTL3fcG1SOU5RFDY4MzbJL2/gvYLRELK6/JPRuI3XYfptrospJ5ncrouIcat
 0kEzPxxKacYNjABGvPAnj6VTHNwmloMk0IUlj2/FxS+SNcFw+9mFJeQ2ClYaTczVzaVhE1v7j/j
 aYYrbE0INoLLe9R6xiPMQdiS7Zoy8=
X-Received: by 2002:a05:600c:1c29:b0:485:3f41:e113 with SMTP id
 5b1f17b1804b1-4854b0ac248mr61254955e9.1.1773245251158; 
 Wed, 11 Mar 2026 09:07:31 -0700 (PDT)
X-Received: by 2002:a05:600c:1c29:b0:485:3f41:e113 with SMTP id
 5b1f17b1804b1-4854b0ac248mr61254285e9.1.1773245250721; 
 Wed, 11 Mar 2026 09:07:30 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe219c41sm160081f8f.29.2026.03.11.09.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 09:07:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Alyssa Ross <hi@alyssa.is>
Cc: kvm@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] accel/kvm: fix typo in variable name
Date: Wed, 11 Mar 2026 17:07:28 +0100
Message-ID: <20260311160728.555402-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311095315.25013-1-hi@alyssa.is>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


