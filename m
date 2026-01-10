Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C30D277CA
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Jan 2026 05:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veRg2-0006YY-94; Sat, 10 Jan 2026 00:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veRfw-0006YC-PE
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:38:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1veRfv-00007m-9r
 for qemu-devel@nongnu.org; Sat, 10 Jan 2026 00:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768023490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=AFqeyPrt+fH91cYUnoLXwx9/CiI22GcssAGYuu2rDgFkBd3VXTESHkkjrc6As6L+P2Ddyj
 Sco+kJwO8fR7nKGmI0vHuzsXXfTQNlWu+hRuZeyUXrR055xApO4IyF/J/7sgcyZ305ERun
 BTJR47dM9MCFdbmEhPFoC4Jo/HbHAVo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-zK8DmYi2NnWvLvHaN6PsKg-1; Sat, 10 Jan 2026 00:38:08 -0500
X-MC-Unique: zK8DmYi2NnWvLvHaN6PsKg-1
X-Mimecast-MFC-AGG-ID: zK8DmYi2NnWvLvHaN6PsKg_1768023465
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430fcf10287so3821015f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 21:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768023465; x=1768628265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=tcFLQ08pn7tQ0AAKGCqnOK4D3+45va7YAXhwqsSg1z34sPl/7gZuwe9Wl7COmGd82d
 rLzAPl0wQd87QdsTH685eMG//Z9WQ17KID+cXX39yDP/Lrt3j7Ozs2bV2+nRNSEe5MqC
 RQBtktYm8poTkLLnhmIIFcwpYbs7X4fvHf7fQjXlC9+G8OvbDtSlGGYJRJvibtNTjGNF
 mYbiBIssPAI+CDdpn52wD2Z3q/QGpywdxj4B4bFV9fFMDvqoUcrxKlQxMYI5upkMC9IO
 ZPply29U3gKP3+GAlRoQjRV4lfJGPZSGGGXq6vq+x67wik4P6dnmbFx8C/8bcxLuF0b8
 /bSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768023465; x=1768628265;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=AWO4gm2AQP2SfIt9hGmWL4JSzfsLAurYuxtmEoV46BQDdt+TSicgvW7P07bnVKIGS1
 KUKkh7NrLJEPWegYZlmlewMzWAevh/rqgeJY6c68IlXKNvbHfPHPekTNLlVlRRwukUQz
 iSgt/OWW4hjx2e1BdYiuZAptuqVJbj7RbB7CxoDPpE7xtG+uoydLBelyStWACfalgbhs
 w+5svZFd+Fd0oBzOjeCpPJ79lZjskLUqINysB80E/J/uz5tr+BNKAEUQfP9Iroej+xDu
 9ZDsEk1cqHBq7Stx1G9bb7CGlPmdGqwUvttsg7q1HGr4m7PafTN4/+TFu6NHLtI2Hzn1
 RaqQ==
X-Gm-Message-State: AOJu0YxRx5hxZjSIBTs42/g/Wh2poJ3VLJ95+42K6RdMqxsI5oArGolx
 qKMTSqIMl1O+pgASN11nIkx0uvipb/hwk2Z0df2spDu0tsNZUUOOOCccKv0DZSiFLl3Qz9G9NWf
 ZGJcahH3p2yH7MmT7KF7WShTEdnlutXVWaeD8qjRZilyy+ugcrnuow3/D
X-Gm-Gg: AY/fxX5VFkaomBUTzI/Q8KMbIqOZ09jAGz9NQqzAR7lJT6IjIDrGSGPloUReGbljBVu
 X1T2ytNbkjIzrVdQV127920eQ4EsoM6gK2id/Gvd9mxqV1WhsQsDHGBWULZprmlAqcL0+Xe5OQn
 YTNsu2oq+rIyqQDdfFGJ6nFz8T5telwnXwWwmUvoqJMENGJyKVRbm1WkeCx7PoVNSyAIiaelZWa
 Fe+hzGXWhER7vv/H73BeX17hAoFrSGS1g31kDOg/UZJZMS2tAi6gTXoOuVyB2LwWTuVxEkt6cqr
 i1tEv4Jk44dXZEb/1E5l2wqTvmEw16I9giq0DzKO6NE2UYfBF70JdvLUAihtil1cP7uFQEIrZ3V
 hR7thw/FqyIdwZCNGmOpe9m1J+kmGqLw6KrK/9t3xeVuFkO6HUJRlJpkCSbWGO4JoLg7tOSEATL
 XiN5VbwQct1OEPZQ==
X-Received: by 2002:a05:6000:2906:b0:431:1ae:a3ca with SMTP id
 ffacd0b85a97d-432c378a162mr15341777f8f.11.1768023465046; 
 Fri, 09 Jan 2026 21:37:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2Co+OsaMd2EB9HMJCiSl2zn8Qdo+kluro6BOK/Y3I+U2WqlLChGPmdbK8SHUr3fIiTHi5wg==
X-Received: by 2002:a05:6000:2906:b0:431:1ae:a3ca with SMTP id
 ffacd0b85a97d-432c378a162mr15341763f8f.11.1768023464663; 
 Fri, 09 Jan 2026 21:37:44 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e180csm25463177f8f.10.2026.01.09.21.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 21:37:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Vulnerability Report <vr@darknavy.com>
Cc: qemu-devel@nongnu.org,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH] hw/i386/kvm: fix PIRQ bounds check in
 xen_physdev_map_pirq()
Date: Sat, 10 Jan 2026 06:37:42 +0100
Message-ID: <20260110053742.853854-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <13FE03BE60EA78D6+20260109023548.4047-1-vr@darknavy.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


