Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E440EF4BB63
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:47:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwV0-0003hT-71; Tue, 24 Feb 2026 12:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuwUr-0003Xp-ID
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuwUp-0005QQ-1Q
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771955212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=cJGb9yYCP4Ln7VfVUkHrVRuBbqWppQbwATv6ub2CiqAqd9ry5wNojeoIF631sCVyCQ8Hd1
 DoAbZFrrg3RL3a7znnfKl0fI2YvXW+dzZaDBBOonv3yWYXWrpwl9Euzvc2FhAStYa3pSyH
 SgN3qPou6wvDocyXpQX6VDQoogv4FQM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-LE95uEMKN2WaUclL23cZrw-1; Tue, 24 Feb 2026 12:46:49 -0500
X-MC-Unique: LE95uEMKN2WaUclL23cZrw-1
X-Mimecast-MFC-AGG-ID: LE95uEMKN2WaUclL23cZrw_1771955208
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837b7903f3so69161655e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771955208; x=1772560008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=XOFvrAc3EtZmF1f41pd+QeP22836oIGUdGrfodwV1cy64rDNXgMgQnf8NJQedoLbHd
 8GZh5RgjusP3M88oQFVoVbGVvq29YfBVMRaa3r+QxDX1d562bS6hS8Dl9YzWEceCEhec
 ff7i9anqi1tylSFeY1WHMrTsrl9y6TvkxiKj5K7TZmp27tvwK+fCcKmqN5GG4V8tDG65
 1jlSTvxHHKqIkOGShEzhmJQqLJIfYKK27L6qlluUC95bpY9fvPweNxY4AB9dh46j/06N
 GZx7lojdeppWOyDeVuKDV96p3Sct7FdAyoI7L7ulW7L/1OMxTzhKq6rIOlQbRWELbPmD
 8GIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771955208; x=1772560008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=GHzqTxBfbe177o4xF6DrfWkXA+sWdMjS2cMP/GF+Ojgqvxvc5ScuyClwCO7AWoOrbR
 8QdiTN4UlFLMSL32bc1jDqbUC7MsAu6xOH1XoVzc4XzeJIRddeODzTZ8XWuGsMYpQGdJ
 NvOjTbD4i80gr9n1HsPFTYc5754e+9whnln+zs4G4o1TSUTNl/ww4wGlP0npKiwQWrYj
 kPNfw99Mqa4dx4WwNhhXlNyQ/U7Wq/1ZQ14UpZYXQuzgDEPCkznfe2gdtGGoS2P8ZdzI
 QlKY3CtgrYltnOPaMS96rSDAYz8QESE3QusOsJBFhstse/16KQVEqcj2ZEabJvBIsYYJ
 kq1A==
X-Gm-Message-State: AOJu0Yw7B73Pf75vv/ilATwqja/2kuF6XOqLeaBCpUa77/suKkZ7p2pg
 4EfbRlR7ufAzQzYypGo/DJGIh+jtfVvLR332Baz2xc/G+QM4DwvsB5bUFAQE4DelN/FFw0TPgK0
 YuIadi2FRmpSTXeen8yoD+Vqn31dFnbAyJ9938UPcKeyAUsP3O9JQ9yZZ
X-Gm-Gg: AZuq6aLfHt6oTPPrqY1ipqVgDrN3fhwnK/LATgbR41p5A01Y8DfM0u6E5qnFu/CIvf7
 nayHedQ3pasPI3NC735/KNHdzRFNS8EXn8hcptOqqGqltmirQHZLGV7gqkrMInoMM329dYI4hqg
 KSFP2FL44P0mSoQUg6tV6bMEtcDll7aN7n7mtbSy/RpD+3+4Qd0kuHnNH0FwQqhCqsZpcIJJA4z
 wmzyJz+aOcc7xlq7fROUgJd8U/GZayVtub8VdeW21DkGWnvOi15OwY4WQIlUo8PUjLjsN8J+oZB
 +ov+OG76ubNue0Cz/t7MwNuwUZEnbdUQDKDUnPHN498XgpTmkfQyp7XLXoRL3OXBJZAwGNKX6U4
 3IDLi1TmEZuD3mHaJk1Y9yMJcAhfQpLYlk2/i9waXRoTkLF/TxQcT3JLamG32KyWJK8bwoEnPLV
 +q8Exo04eoG5g0VkLdlk/WKV2InOk=
X-Received: by 2002:a05:600c:5020:b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-483a95fb29cmr250743905e9.9.1771955208032; 
 Tue, 24 Feb 2026 09:46:48 -0800 (PST)
X-Received: by 2002:a05:600c:5020:b0:47e:e2ec:995b with SMTP id
 5b1f17b1804b1-483a95fb29cmr250743555e9.9.1771955207645; 
 Tue, 24 Feb 2026 09:46:47 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483beb3878esm260775e9.18.2026.02.24.09.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 09:46:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] accel/kvm: Don't clear pending #SMI in kvm_get_vcpu_events
Date: Tue, 24 Feb 2026 18:46:26 +0100
Message-ID: <20260224174626.107781-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223221908.361456-1-mlevitsk@redhat.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
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


