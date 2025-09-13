Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1412CAC58E
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 04:36:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxHyu-0004Nk-L6; Sat, 13 Sep 2025 00:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxHyq-0004Ms-8Q
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 00:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxHyo-0003o3-F5
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 00:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757738115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=aNNig8IYYdAPatRPAlT4JtfAF6iVzHoed3BTuZIPR6pdri3jOZhvZUqloAFlhiaH7JNm6d
 +gTT2gPBm0viwuOlTlUvWIvvH9e3IIWTWvKRRaZUkUwPTF19vN2c/T4SZ22UTs8RrcdwxT
 DIb5KmLLYSaNO+AVNEPMdFOpk0I5CME=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-tMI4RlcuNquDW8w--x7j3Q-1; Sat, 13 Sep 2025 00:35:14 -0400
X-MC-Unique: tMI4RlcuNquDW8w--x7j3Q-1
X-Mimecast-MFC-AGG-ID: tMI4RlcuNquDW8w--x7j3Q_1757738113
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b920e0c25so16540795e9.3
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 21:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757738113; x=1758342913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=T8cENXn96DM8+51li2YIHrjhvSEeteAHJD52CtPGudUNTHAx8tyr6x/YC6fz5fvGuR
 /kGnrMikJWiyzlqmS2LvbRYSIiDRzMBzn5+6yVjwUsSKOzs/CorbSdQR5HfoinSV+IGu
 a/pyDDXAoVffGSuLEAeTq/NNFAfhmrqLxUL7innpxauKazLC3qxF4Z3Sgz60tOZxghVR
 /Y1+leFib9C1A2sqwAf30PfTcZNtoJwTSyK2Va4zMI9XGOeRVRkeMzlOM2Fbc8V/3Z7a
 C5JVQZhjiMcry2RA9baGfpRo6lwrDEY+RM65F9W7D5JLJPYavet+d/Ft6e2xbq7jQQR6
 UCFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwJRBygzgJUJNYgra+6+/ilU9h0Av9N+69RF/vSwdGqBTPW1bhbvfIz+ohjeWfwSx0gZeEu0YbATtU@nongnu.org
X-Gm-Message-State: AOJu0YxwUugCRD41KEt1UVsIUq5YusUMKtQiLyU623xbZp26jqUvA1i2
 7KG1qjkfZlW8djDOEpbjqkvACoaSD3c6KGjmv2RQpTpLcTDz7dZWBgld5JIWtZdmTAjB8RB4c11
 B6QJAceKN82vu7YSyEmWT52MH+1PZlBGWGpdWTvvjzLylXvYPpM3HEueA
X-Gm-Gg: ASbGncvhKAD1OttaNCxuXU8ewUsdITsqJtzIbfhBNhLQgZX9JG8Fb5+K7jhHATNZbBK
 9DV+8DfLoV5HOADeusADcy0nLQhz1w7vL6iVWOwzYN0KJUL0K0mDdZEQUchajuV8f5OvyTezirF
 8pm6UJHUeP0GWS6/3qOdRfMGQj/hIuUqcgvWv5XP0UzmXikSzTuMIlbTGYD5Mfag+0qjQb06e2Y
 xOeRkcZqxyjp/eTPgoSCBdsQjB8vCDuv1dc9HvsGA6hCESpmOJ892p4t8z8dC7OjNEwAjtYb2gc
 hxNLi3oCi5Krl4OCU12dkPBROYv4lqeESks5ErJpe9v+WitJuTCTduF2bDliPbEBrZMUQXS/J0A
 DYkV+kx2VyenbMNDFhkMewhMpe6UAYYghki+P4h1j5Ag=
X-Received: by 2002:a7b:cd0b:0:b0:45d:dbf4:8880 with SMTP id
 5b1f17b1804b1-45f211efda6mr30975135e9.27.1757738113050; 
 Fri, 12 Sep 2025 21:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFH6iJaz0mq774dFtPfmBg8sCpRJDY/WH4Bw/wQfHTFRdvvBcfJ4TKag7YaZSfBM78LnYlvg==
X-Received: by 2002:a7b:cd0b:0:b0:45d:dbf4:8880 with SMTP id
 5b1f17b1804b1-45f211efda6mr30975085e9.27.1757738112714; 
 Fri, 12 Sep 2025 21:35:12 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e764eacc0csm6023698f8f.18.2025.09.12.21.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 21:35:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/3] kvm: guest_memfd enhancement and fix for
 KVM_SET_USER_MEMORY_REGION2
Date: Sat, 13 Sep 2025 06:35:10 +0200
Message-ID: <20250913043510.2549873-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250728115707.1374614-1-xiaoyao.li@intel.com>
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


