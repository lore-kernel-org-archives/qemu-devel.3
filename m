Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F523C5B555
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 14:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMSsI-00010l-5h; Tue, 03 Jun 2025 10:44:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMSs9-0000zm-QQ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:44:15 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMSs1-0002Ne-3u
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 10:44:12 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a365a6804eso4293875f8f.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748961839; x=1749566639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ej1WLHRtQogBZXpAK07IGpaR+2X1F2rJXfCoNf4yQsQ=;
 b=OMh2e32/mADmHDxAsIGvQpRz7oFudgK6uMBDZdt9tB1ZhfxXWJ8w7bK7SAOhndzAke
 7VRPv4OdJEIZwJEW98h5QZhivk5evt+libQp8WleE6s3dwQCSeGs1y3EvyX06zEdjZe+
 OGFrutQRdc7BX/FrHPJ6tXrIRvSnXMR4YM9ubVSSp2mL8WCBbXHzZTzqsCkXCGrhXKCk
 9ZCoBWwcKKTPaoNUVnDJqY2zACtCT9GkRt2uWB1vmLFd0LBmgD+ixLTrprVzo9NgNKe8
 elXzXHDkA3laAc4t4Fq5ZAbmt1mdtrqMEP6oxtrWa2hI8K4p6o3QSKqIoVU2rqNitqNO
 P4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748961839; x=1749566639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ej1WLHRtQogBZXpAK07IGpaR+2X1F2rJXfCoNf4yQsQ=;
 b=wkDoI0/lHvwSBkMlcA+EwartMO6HRH55yMP8UI/1cf3h04Weo6TqlW+t6ZjB+R3v3P
 2KfJRH6tgkVLl/8B80uZP2PgBHIPULx0R3ac957QklMdlvmVfmcgzFFTz7dZ9PBTwhnl
 jvslNGgAfoOuFYc9dM4kW2Tt1l7To/SYvC49JuheY4/+SHdP3YWmPznidCmyp6ut9bK5
 FlmRboJ/2EeskaJ973m6QYDHx1zBycnk/U8o/w9uq93vBI24sf9Ss+FjUZuQbiT9FLfo
 IZML7FxrxMW+AG+FrmHgw5t8cQUcWmWqR4J/5Y4fYeGnqQkq3+F6BWbC0gAhxiF59jdT
 dJnQ==
X-Gm-Message-State: AOJu0Yz2KTJNse0eqOk/XYelTNrmezH1enrS6j9YgHTFW6skGh/ahdbe
 AmKOa0hlt1n15qqkYTxRcPwL5TkB2GRC8eojVCy0z60ySOAUQoo4+uJHvjCNA9JihzE=
X-Gm-Gg: ASbGnctWr+/2wXqp/aYyFzJdwk8jgivNq+3yDz8ElUcLljbq1nxSVEiO9T+qJsn/fhS
 H148B2ioeLYMi4G+HJK4fj7CD4UQX82mcpgj/MBTtwmAtlL4uM11JWYWfcDKkQKs6seCitwaiio
 FiezK0kzZJ5ubVEKwqC8BJXZYvPddhtwlnCDra7zQswiiX6qjrC5WSodMLaiT3c+ZFLgOuy1AJm
 /cxA3NsUh1og86yTcROrXxTD7i+9Crq59m4Q3LxZICn8udhopElvH2Cl724HKerH4P+XTCD7yxu
 ngv2Jdn1XBhlFLAGd2Lbinqyih8EZuvsWdJRcx8T488Vi54tXhq0sW4aiSPTfmKHz0yzORDgyRn
 KKDJJfBKVosVTZz2JmcwCFQsGyVTpkcV5DYLee1c/Rr15Gg==
X-Google-Smtp-Source: AGHT+IGUNGa9PVvIW82XC2aH8Y3fOiJY3XNjxZBfp3uNXnzkFaEpwBvCheuS5mXFkBptD602oDO/cw==
X-Received: by 2002:a05:6000:4382:b0:3a4:eef5:dece with SMTP id
 ffacd0b85a97d-3a4f7a7139emr15115324f8f.35.1748961839469; 
 Tue, 03 Jun 2025 07:43:59 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f1b0a4sm165568315e9.0.2025.06.03.07.43.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 07:43:58 -0700 (PDT)
Message-ID: <a2807c77-d1ae-4f17-8fdd-94bd7e94a69b@linaro.org>
Date: Tue, 3 Jun 2025 16:43:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/23] ui/vnc: take account of client byte order in pixman
 format
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250522102923.309452-1-berrange@redhat.com>
 <20250522102923.309452-3-berrange@redhat.com>
 <e6c7920b-8078-4d97-92ce-2efafb645953@redhat.com>
 <aD79d0XPK_dARai_@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aD79d0XPK_dARai_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 3/6/25 15:49, Daniel P. Berrangé wrote:
> On Tue, Jun 03, 2025 at 01:18:55PM +0200, Thomas Huth wrote:
>> On 22/05/2025 12.29, Daniel P. Berrangé wrote:
>>> The set_pixel_conversion() method is responsible for determining whether
>>> the VNC client pixel format matches the server format, and thus whether
>>> we can use the fast path "copy" impl for sending pixels, or must use
>>> the generic impl with bit swizzling.
>>>
>>> The VNC server format is set at build time to VNC_SERVER_FB_FORMAT,
>>> which corresponds to PIXMAN_x8r8g8b8.
>>>
>>> The qemu_pixman_get_format() method is then responsible for converting
>>> the VNC pixel format into a pixman format.
>>>
>>> The VNC client pixel shifts are relative to the associated endianness.
>>>
>>> The pixman formats are always relative to the host native endianness.
>>>
>>> The qemu_pixman_get_format() method does not take into account the
>>> VNC client endianness, and is thus returning a pixman format that is
>>> only valid with the host endianness matches that of the VNC client.
>> ...
>>
>>   Hi Daniel,
>>
>> this patch breaks the output in the TigerVNC viewer for me.
>> If I run "./qemu-system-x86_64 -vnc :1" on my laptop, and then connect to it
>> via "vncviewer :1", the output of the BIOS now appears in yellow letters
>> (instead of grey ones).
> 
> It turns out that historically we never set the 'client_be' flag
> when a client does NOT send a "set pixel format" message. By luck
> this was OK for little endian platforms as the default value of
> 0 matched little endian.
> 
> When I replaced 'client_be' with "client_endian", the default
> value of 0 matches neither big or little endian.
> 
> I didn't see this with remote-viewer as it unconditionally
> sends "set pixel format", but tigervnc always uses the server's
> default pixel format.
> 
> So this patch is fine, but it exposes a pre-existing latent
> bug there was probably causing problems on big endian platforms
> in the past, but now causes problems on little endian platforms.

Nice :)


