Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7596E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:07:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIuif-00027A-DG; Wed, 04 Dec 2024 14:07:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIuiS-000256-89
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:07:17 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tIuiQ-0005C3-Ki
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:07:16 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385deda28b3so123030f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733339233; x=1733944033; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s/uUSJl0KY8AFLs//UevlIhCcXiaJbGMsB4Vl+DIbJc=;
 b=Xg6qEV3t9cCESBGgygMA5K0A2TTdkkNETPMnLg2cipO4URku6KZT4gL3GgtgvDucMv
 XmXU3/sAUZ00ohFnlWppSL5UqBAA/Y1+d9RpnYMENGuLOSIwNsg1RupSiXcR8eQlbO6t
 jm8PW0TzOlcc7UG1rNlwo8JkAzjbrbCdGBOBx9xdJcjI0cmHRSplLplEAM459JUfGV9J
 mw532tG9+QwDfHfoCJSsTR6swqCzK/zw2fmUtrO2OG5r74H9kEQ9zNDS44xqhJcarYzW
 B6CuntX50pHrAgGuUWelw3YiyZ7gC0pysqI9+wHrbR/VhYQ26Xn4+mOj4/x4mcMrGbDB
 z3lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733339233; x=1733944033;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s/uUSJl0KY8AFLs//UevlIhCcXiaJbGMsB4Vl+DIbJc=;
 b=p4Ujd4T2nEUxFzm5gFBANXABDr/3msnUfj7EqvB45GH60l25rBralOEFwEGWmh/ypl
 w9coxmJ0D+m6iQESyfq+pocFwgyIW5m3Gwkb0fJfmJt4dNkz089Dcd1z/Q+OmPJo5DVs
 SQAoRRcVd/j/eJPpN+QoN2rSUfmhYw3wOFplIvixEjwzRFQlySln2d2wzqCta8SFgv74
 nDma5YR/pvk7FZoAnVGO6ZaU1z8r5ormX8M3N0KlxKRpJ8/w1tiRAvBQ4bxAUE2j7jdc
 ijD4oW9Rs6KTc/U0iK+S85gMilnMpWfgF4+q9B1JvEPULWEqKhkP6VuC7k4E6DVjHQP1
 hDtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFkAcp6+EvWHe/J/r0mFKjfOKAT4SFwZG6yQF/QVq8Z6Iehj4KUdfxwhdB5xKexo6eF7RB85uSjZdY@nongnu.org
X-Gm-Message-State: AOJu0YxKR+UxtaMzrp70UQL4F56NfHJroNkPAdx8l12I0Mb2kWwtVTJy
 sp307L1BwNuwPpcJ+QMeFQPe8qfRb+txKkoVq728jjV2INlysWWKBqFRmSF/ZfE=
X-Gm-Gg: ASbGnctvj+QKmh++vANWdBgENTkFB1TdInFHoivwPe+laar3mpzn+JOfCay+fq/wfkp
 YF8vBzkf0qR2Hz9c0RY/xgjlK/K9qoMbqW/f0ZIzPS/E8W6mE47aryQ+9wn/iwpCQj9uogR0tg0
 Norlg2418RK3qwvoEoWjeMHf5ABU2WyYCbO7ErVHk8qJASD3IRitkhwDlUjG70HFb5kQvgEvDzG
 CSxrrFiNInF0z8zQZratfFqd2wT/+u8hYoya9exjOhhgSJq
X-Google-Smtp-Source: AGHT+IGSjo/OubjoeEuO6JIctiXQHdbhPQjT8nM+5lrqkZPG5u8xgrKE2CVQCrepNTIhQbp7+Sy7fg==
X-Received: by 2002:a5d:59a2:0:b0:385:df4e:366f with SMTP id
 ffacd0b85a97d-385fd42a71bmr5545868f8f.38.1733339233044; 
 Wed, 04 Dec 2024 11:07:13 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385e9c075e8sm12546939f8f.7.2024.12.04.11.07.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:07:12 -0800 (PST)
Date: Wed, 4 Dec 2024 19:07:36 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 philmd@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 02/26] target/arm: Add confidential guest support
Message-ID: <20241204190736.GB2349278@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-4-jean-philippe@linaro.org>
 <Z0XA7tNaD3iFZ8uM@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z0XA7tNaD3iFZ8uM@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 26, 2024 at 12:37:02PM +0000, Daniel P. Berrangé wrote:
> When you create a new "user creatable" object, there should also be a
> corresponding addition to qapi/qom.json.
> 
> I believe you have the qom.json addition in a later patch, but it
> should actually be here 

Yes, I'll move it here

Thanks,
Jean

