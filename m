Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282BDC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 19:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPS6M-0004lD-50; Thu, 04 Jul 2024 15:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPS6K-0004kj-0r
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:26:40 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPS6H-0005IW-E7
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 15:26:39 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-70df2135426so535727a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 12:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720121195; x=1720725995; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GAC6jHN8VZhA09F2X3Jk8b+6bboZn4diELXlRBPKZmM=;
 b=fccwkiZJRF0vq90lzpj/xM6RgEbjMJTIaMf1kxLkhn5C2UpwEpL1/Obe21aERLmLsL
 Ytr5P7Fv3VxReR0/fS9X+7RPz36n/RlSBRr51+xA4WURtDaUCCO7gE6gTT7Ldq0yUdM8
 dHE/TUTQdI/KH4v35Br8OwZK/GxBjBRQw/VE1XCAFGqIsmsiDkJ74DsT/F44Ox3yzWR9
 uIr+xn4dMGsfbhqq+u17e8gub10uNgzbdIJ6cbhp/LikeaHb1A7BN3PzxJADMDgN3LLC
 7NrvrWIaJmC+yzT27yTS+GCDYd94Uy1mTUqSMm0IDPZHNi242o9ynrnLYwf9lFqlz0Hp
 fgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720121195; x=1720725995;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GAC6jHN8VZhA09F2X3Jk8b+6bboZn4diELXlRBPKZmM=;
 b=dMxTHN8sY0nm4u0t5FPDGhbpy61HuCpjFR9Qm7qiiMeL5De6vV3c2s+0xL0uj1Z988
 qe+eNzi2SYE4niYii+ZRjbKc6RuU/rJ1CZo1koeI/rB03LK+IqfE52vofLV6FwL7uVZO
 Qbl5fNNShVKYS8yVP7pfLrMHORwRWfdDcgVJhPwsrL1xp75jijJDEhQ8EWcyfymGkjYr
 I01Y74rZSUFDFIrNXBMg7duiY4RnVyrkwHsi7yhXdczXEpmh67wFSAtdJmILRr+rpwzB
 obPgWpZYkTCWSbVYOB464TK9m2yXtH/U8/XqEcioyrQGpZJOi2tzBbbXIVnFmXxfno6h
 PL/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5PV9IYIaK8aWyWnTs1+MppuTAeQa5Ya9g/ugRMT0SI2nChFrIXkbxb0YTPCGfoxqKnY835y+l4gDoWY8j6SEf0dsjNJc=
X-Gm-Message-State: AOJu0YyuHq4MLge+e8oQAWqyN2MYVFBgF5qQgSGJu7hb1bktZH9DXCcd
 c9H38Y9vjWflNgW9R2I7xMz4wXwCuA2tKIduXhX0JT1yTPxj8C0X9zcWJwp+HhU=
X-Google-Smtp-Source: AGHT+IExypEFeSgfgYY6BYAJX0PibjEELDtwnJEI8NOQRrmzfiYRGoqBvD2xEJ7NMDNTgnGuaYjGcw==
X-Received: by 2002:a05:6a20:841e:b0:1be:ca6c:d93 with SMTP id
 adf61e73a8af0-1c0cc8effa5mr2817986637.52.1720121195281; 
 Thu, 04 Jul 2024 12:26:35 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1e50f63asm32862635ad.138.2024.07.04.12.26.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 12:26:34 -0700 (PDT)
Message-ID: <0d85e013-1c38-4781-8fd6-5e837327f33f@linaro.org>
Date: Thu, 4 Jul 2024 12:26:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] rust: example of bindings code for Rust in QEMU
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Paolo,

thanks for this series!
Some comments below.

On 7/1/24 07:58, Paolo Bonzini wrote:
> Hi all,
> 
> this is an example of what some bindings code for QEMU would look like.
> Note that some parts of this code are barely expected to compile, and
> are probably full of bugs, but still should look like finished code
> (in fact, because they compile, the type system parts should be okay;
> though a conditional "should" is required).
> 
> This code is not integrated in the QEMU source tree, because again it
> is just a example of what kind of Rust code would exist to handle the
> C<->Rust FFI.  The translation of a handful of C structs and function
> prototypes is done by hand rather than with bindgen, in particular.
> 
> The patches are organized as follows:
> 
> Patches 1-2 introduce the skeleton for the rest of the code and are
> not particularly interesting, since that skeleton would be provided
> by the patches that introduce Rust usage in QEMU.
> 
> 
> Patches 3-4 define common code to handle conversion of data structures
> between Rust and C.  I couldn't find an existing crate to do this,
> though there are similar concepts in glib-rs.  The crate defines
> variants of Clone, From and Into that convert a Rust struct to a
> C pointer, for example:
> 
>     let s = "abc".clone_to_foreign();        // mallocs a NULL-terminated copy
>     let p = s.as_ptr();
>     drop(s);                                 // p is freed now
> 
> or the other way round:
> 
>     let s = String::cloned_from_foreign(p);  // p is a *const c_char
> 
>     let t: String = p.into_native();         // p is a *mut c_char and is free()d
> 
> The second patch defines what you need to convert strings from and to
> C.  It's used by tests but also by a couple of QOM functions implemented
> below; it lets you forget the differences between String, &str, CString,
> &CStr and Cow<'_, str>.
> 
> This is the only complete part of the skeleton (in fact I wrote it
> a couple years ago), and it comes with testcases that pass in both
> "#[test]" and "doctest" (i.e. snippets integrated in the documentation
> comments) styles.
> 
> 
> Patch 5 (mostly complete except for &error_abort support and missing
> tests) allows using the above functionality for the QEMU Error*.
> 
> 
> Patches 6-8 provide an example of how to use QOM from Rust.  They
> define all the functionality to:
> 
> - handle reference counting
> 
> - handle typesafe casting (i.e. code doesn't compile if an upcast
>    is invalid, or if a downcast cannot possibly succeed).
> 
> - faking inheritance since Rust doesn't support it.
> 
> While I started with some implementation ideas in glib-rs, this has
> evolved quite a bit and doesn't really look much like glib-rs anymore.
> I provided a handful of functions to wrap C APIs.  For example:
> 
>     object_property_add_child(obj, "foo", object_new(TYPE_BLAH))
> 
> becomes
> 
>     obj.property_add_child("foo", Blah::new());
> 
> ... except that the former leaks a reference and the latter does not
> (gotcha :)).  The idea is that these functions would be written, in
> general, as soon as Rust code uses them, but I included a few as an
> example of using the various abstractions for typecasting, reference
> counting, and converting from/to C data strcutures.
> 
> A large part of this code is of the "it compiles and it looks nice, it
> must be perfect" kind.  Rust is _very_ picky on type safety, in case you
> didn't know.  One day we're all going to be programming in Haskell,
> without even noticing it.
> 
> 
> Patches 9-10 deal with how to define new subclasses in Rust.  They are
> a lot less polished and less ready.  There is probably a lot of polish
> that could be applied to make the code look nicer, but I guess there is
> always time to make the code look nicer until the details are sorted out.
> 
> The things that I considered here are:
> 
> - splitting configuration from runtime state.  Configuration is
>    immutable throughout the lifetime of the object, and holds the
>    value of user-configured properties.  State will typically be a
>    Mutex<> or RefCell<> since the QOM bindings make wide use of interior
>    mutability---almost all functions are declared as &self---following
>    the lead of glib-rs.
> 
> - automatic generation of instance_init and instance_finalize.  For
>    this I opted to introduce a new initialization step that is tailored to
>    Rust, called instance_mem_init(), that is executed before the default
>    value of properties is set.  This makes sure that user code only ever
>    sees valid values for the whole struct, including after a downcast;
>    it matters because some Rust types (notably references) cannot be
>    initialized to a zero-bytes pattern.  The default implementation of
>    instance_mem_init is simply a memset(), since the callback replaces the
> 
>      memset(obj, 0, type->instance_size);
> 
>    line in object_initialize_with_type().  I have prototyped this change
>    in QEMU already.
> 
> - generation of C vtables from safe code that is written in Rust. I
>    chose a trait that only contains associated constants as a way to
>    access the vtables generically.  For example:
> 
>      impl ObjectImpl for TestDevice {
>          const UNPARENT: Option<fn(&TestDevice)> = Some(TestDevice::unparent);
>      }
> 
>      impl DeviceImpl for TestDevice {
>          const REALIZE: Option<fn(&TestDevice) -> Result<()>> = Some(TestDevice::realize);
>      }
> 
>    This works and it seems like a style that (in the future) we could apply
>    macro or even procedural macro magic to.
> 
> - generation of qdev property tables.  While only boolean properties are
>    implemented here, one idea that I experimented with, is that the
>    default value of properties is derived from the ConstDefault trait.
>    (ConstDefault is provided by the const_default external crate).  Again,
>    this is material for future conversion to procedural macros.
> 
> I absolutely didn't look at vmstate, but it shouldn't be too different
> from properties, at least for the common cases.
> 
> 
> Patches 11-14 finally are an example of the changes that are needed
> to respect a minimum supported Rust version consistent with what is in
> Debian Bullseye.  It's not too bad, especially since the current version
> of the QOM bindings does not require generic associated types anymore.
> 
> 
> Why am I posting this?  Because this kind of glue code is the ultimate
> source of technical debt.  It is the thing that we should be scared of
> when introducing a new language in QEMU.  It makes it harder to change C
> code, and it is hard to change once Rust code becomes more widespread.
> If we think a C API is not fully baked, we probably shouldn't write
> Rust code that uses it (including bindings code).  If we think a Rust
> API is not fully baked, we probably shouldn't add too much Rust code
> that uses it.
> 

Shouldn't we focus more on how we want to write a QOM device in Rust 
instead, by making abstraction of existing C implementation first?
Once we have satisfying idea, we could evaluate how it maps to existing 
implementation, and which compromise should be made for efficiency.

It seems that the current approach is to stick to existing model, and 
derive Rust bindings from this.

I agree this glue can be a source of technical debt, but on the other 
side, it should be easy to refactor it, if we decided first what the 
"clean and idiomatic" Rust API should look like.

A compromise where you have to manually translate some structs, or copy 
memory to traverse languages borders at some point, could be worth the 
safety and expressiveness.

> We should have an idea of what this glue code looks like, in order to make
> an informed choice.  If we think we're not comfortable with reviewing it,
> well, we should be ready to say so and stick with C until we are.
>

While it is important that this glue code is maintainable and looks 
great, I don't think it should be the main reason to accept usage of a 
new language.

> The alternative could be to use Rust without this kind of binding.  I
> think it's a bad idea.  It removes many of the advantages of Rust
> (which are exemplified by the above object_property_add_child one-liner),
> and it also introduces _new_ kinds of memory errors, since Rust has
> its own undefined behavior conditions that are not there in C/C++.
> For example:
> 
>      impl Struct {
>          pub fn f(&self) {
>              call_some_c_function(Self::g, self as *const Self as *mut _);
>          }
> 
>          fn do_g(&mut self) {
>              ...
>          }
> 
>          extern "C" fn g(ptr: *mut Self) {
>              unsafe { &mut *ptr }.do_g();
>          }
>      }
> 
> is invalid because a &mut reference (exclusive) is alive at the same time
> as a & reference (shared).  It is left as an exercise to the reader to
> figure out all the possible ways in which we can shoot our own feet,
> considering the pervasive use of callbacks in QEMU.
> 

I agree with this point that you made on the original RFC series from 
Manos. Just calling qemu C API through unsafe code is not making the 
best possible usage of Rust.

> 
> With respect to callbacks, that's something that is missing in this
> prototype.  Fortunately, that's also something that will be tackled very
> soon if the PL011 example is merged, because memory regions and character
> devices both introduce them.  Also, as I understand it, Rust code using
> callbacks is not particularly nice anyway, though it is of course doable.
> Instead, this exercise are about being able to write *nice* Rust code,
> with all the advantages provided by the language, and the cost of
> writing/maintaining the glue code that makes it possible.  I expect
> that we'll use a technique similar to the extern_c crate (it's 20 lines of
> code; https://docs.rs/crate/extern-c/) to convert something that implements
> Fn(), including a member function, into an extern "C" function.
> 

It could be an interesting thing to explore. Is the best solution to use 
specific traits (no callbacks involved from Rust code), or should we 
have Rust closures that mimic this behavior.

We could have a specific trait with functions to handle various kind of 
events. And the glue code could be responsible to translate this to 
callbacks for the C side (and calling Rust code accordingly, eventually 
serializing this on a single thread to avoid any race issues).

> 
> Anyhow: I think we can do it, otherwise I would not have written 2000 lines
> of code (some of it two or three times).  But if people are now scared and
> think we shouldn't, well, that's also a success of its own kind.
> 
> Paolo
> 
> 
> Paolo Bonzini (14):
>    add skeleton
>    set expectations
>    rust: define traits and pointer wrappers to convert from/to C
>      representations
>    rust: add tests for util::foreign
>    rust: define wrappers for Error
>    rust: define wrappers for basic QOM concepts
>    rust: define wrappers for methods of the QOM Object class
>    rust: define wrappers for methods of the QOM Device class
>    rust: add idiomatic bindings to define Object subclasses
>    rust: add idiomatic bindings to define Device subclasses
>    rust: replace std::ffi::c_char with libc::c_char
>    rust: replace c"" literals with cstr crate
>    rust: introduce alternative to offset_of!
>    rust: use version of toml_edit that does not require new Rust
> 

