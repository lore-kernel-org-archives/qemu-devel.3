Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7C9CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEE0d-00019I-89; Wed, 29 Oct 2025 17:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE0P-000128-Vc
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:47:00 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE0A-0006Tj-8Q
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:46:56 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4770e7062b5so2345745e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774388; x=1762379188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/+DITEUqnNP7BCcatCMcmAtM/fKrxvvfAMRydrHbu1c=;
 b=AByWHUe6wOcsSAfdkgny6VrSkRinBerCloDlcuN5j692RFcRT6dcvgkezW7bk5HGTX
 b7q0j4dcB6Jxa2GlwlVhz/gKLflZu9NB4eZuVkLd3PABe7iIysSDjJz7NqU/6NZwMUON
 Owm9g/dWHXwatKPuMPe2cU3VwFnZi2RPz5dWRoj1puEI6BS9/HoRZE6o2jSRosK5AEDt
 k/4AvVJZLhmBSvFGDH9b/UoZS6bouxxhTRrCCer/aNf+eWjNZGe9+bkmmPcPE6tBjvsE
 bFClvAldWrjkQXydlRNjyKuw+U1o/bk/ki9A6KoMLwuLKGMzTo2gaDtyHHZLgdFzO9QG
 toFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774388; x=1762379188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/+DITEUqnNP7BCcatCMcmAtM/fKrxvvfAMRydrHbu1c=;
 b=DQ9wCAdnM9CHXs9nOaK7gNsobxupYhCO9lKvCNY1+ICz8yI301+UzrBm0q39jSXZuZ
 M/gw+zSlRYPHWHU+OOKjvbMtS91w7EEhC67X7+i0kXuzZraSy7HS5wRwn/wN2+nejgpt
 gQKyddLvqe8+cXtmZxCTyC5oPV3jBqCAZRxC1frrH6sy4WKhR0ATclPxpFN5o1JSEOWF
 mHf+ZAGYoETS/Bgbk6e2Ghpmkf9kFDuSESGHcQzGMhxqFZxfcfvUIxX39vRT1/RQZM+P
 N48xc2OVVpDNLlChQzHTQfyF9EI2+ptpuPlIjjI9/oSayswE7wGpuTWYPZCmobEMLPBl
 Mf8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk+y8gjxh5CzlmPMaiK34GtsUmSjojpxwFwy8LhfXRkkVFqmSd0o3Jt7uH49abYcuiMoEDSnmeZXX4@nongnu.org
X-Gm-Message-State: AOJu0YzXGSrbyhUSoiyRygV1hg42PBKdAYtkP2oIHWMSOa1EJewahUvo
 En8eytO9fN94Dtpl5a42B+hdgZ+SQcXtHMU9mZ0/oGt+DxXIwHvI9h19Fb56GhLC1po=
X-Gm-Gg: ASbGnct50czPfPJSIKn/p5yy9rZEV7HgIAhRmL0tJlFoWs09po5PNrxgAXyWqS1I3y+
 5t4ZHTP1vil3oBF02zGNA9JF5yf5z0ojPiSVWYva8zMpu3MbGeES7MF6dH5F4UNkwPAHAqwEZy9
 +1XHmj7CLngy1KmlnIJ+oBizvBjQytJ2MBJnhQjn6Lusmj2EbsmAlPrL4l/t0K6s+wd4yKQbVpM
 I3DJrLe02kfONHwVkLnuhk0O/b3tnw/764ivPVxI3h7fNjfIHWHzLtBgBURt2XzwtuledgxFd1P
 EUAl+ROvsAY6FiiV4GZ8/+C8TrX0qSwxPnncBDpuXT+1nT5Cvs9He+A3Z3l0wysCmw9sc1qNl8n
 FZfSXcmhSi4E56+MbS+1dJQxeGYytTM2ZrNewSE3S16lV5FF2dgP6wsirW7JgS2Fs5/agqqDjEi
 Svc+5VgpvUrGacm/m4qJyIxTrs6Vmf4rQYRmgFP5eNv2c=
X-Google-Smtp-Source: AGHT+IHghAnyYt/9CZ9HchAxLLZbVy0Zf7yKLjdqFlxRpok0ysIg8K6FaIQQYnMhsPdr3rD28MC//Q==
X-Received: by 2002:a05:600c:5197:b0:46e:2e93:589f with SMTP id
 5b1f17b1804b1-4771e17ef8cmr44273815e9.14.1761774388499; 
 Wed, 29 Oct 2025 14:46:28 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772899fdfbsm4351795e9.4.2025.10.29.14.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:46:27 -0700 (PDT)
Message-ID: <9777ac6c-2e36-460d-a4b7-a2d3b53a4482@linaro.org>
Date: Wed, 29 Oct 2025 22:46:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/35] hw/audio: simplify 'hda' audio init code
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-7-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> For consistency, use only qdev_device_add() to instantiate the devices.
> We can't rely on automatic bus lookup for the "hda-duplex" device though
> as it may end up on a different "intel-hda" bus...
> 
> This allows to make init() callback bus-agnostic next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/intel-hda.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


